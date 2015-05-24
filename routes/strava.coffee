express = require('express')
httpProxy = require('http-proxy')
http = require('http')
request = require('request')

router = express.Router()

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
