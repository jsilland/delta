express = require('express')
httpProxy = require('http-proxy')
http = require('http')
request = require('request')
config = require('../config/strava')

router = express.Router()

router.get('/exchange', (req, res) ->
  if req.query.error
    res.render('authenticate', {title: 'Authenticate'})
    return
  request.post('https://www.strava.com/oauth/token',
    form:
      'client_id': config.strava.api.client_id
      'client_secret': config.strava.api.client_secret
      'code': req.query.code
    (error, response, body) ->
      console.log("Access token exchanged: #{JSON.parse(body).access_token}")
      res.cookie('strava_access_token', JSON.parse(body).access_token, path: '/')
      res.redirect('/feed')
  )
)

router.get('/*', (req, res) ->
  if req.cookies.strava_access_token
    params = []
    query = ''
    for param, value of req.query
      params.push("#{param}=#{encodeURIComponent(value)}")
    if !!params.length
      query = "?#{params.join('&')}"
    url = "https://www.strava.com/api/v3#{req.path}#{query}"
    console.log("Forwarding Strava API request: #{url}, token: #{req.cookies.strava_access_token}}")
    request.get(url,
      headers:
        'Authorization': "Bearer #{req.cookies.strava_access_token}"
      (error, response, body) ->
        if response.statusCode == 401
          res.clearCookie('strava_access_token')
          res.redirect('/')
        else
          res.send(response.statusCode, body)
    )
  else
    res.redirect('/')
)

module.exports = router
