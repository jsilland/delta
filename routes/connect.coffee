express = require('express')
request = require('request')
config = require('../config/strava_api')
glob = require('glob')

router = express.Router()

router.get('/', (req, res) ->
  redirect = '/record'
  if req.query.redirect
    redirect = req.query.redirect
    
  res.render('connect', {
    title: 'Connect with Strava',
    clientId: config.strava_api.client_id,
    host: 'http://localhost:1337',
    redirect: redirect,
    photo: '/assets/images/splash/road.jpg'
    }
  )  
)

router.get('/exchange', (req, res) ->
  if req.query.error
    res.render('connect', {
      title: 'Connect with Strava',
      clientId: config.strava_api.client_id,
      host: 'http://localhost:1337',
      redirect: req.query.state,
      photo: '/assets/images/splash/road.jpg'
    })
    return
  request.post('https://www.strava.com/oauth/token',
    form:
      'client_id': config.strava_api.client_id
      'client_secret': config.strava_api.client_secret
      'code': req.query.code
    (error, response, body) ->
      console.log("Access token exchanged: #{JSON.parse(body).access_token}")
      res.cookie('strava_access_token', JSON.parse(body).access_token, path: '/')
      res.redirect(req.query.state)
  )
)

module.exports = router
