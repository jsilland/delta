express = require('express')
router = express.Router()
config = require('../config/google_maps')

router.get('/', (req, res) ->
  if req.cookies.strava_access_token
    res.redirect('/feed')
  else
    res.render('index', {title: 'Cotton - Home'})
);

router.get('/feed', (req, res) ->
  if req.cookies.strava_access_token
    res.render('feed', {title: 'Cotton - Feed', google_maps_api_key: config.google.maps.api_key})
  else
    res.render('index', {title: 'Cotton - Home'})
);

router.get('/activities/:id', (req, res) ->
  if req.cookies.strava_access_token
    res.render('activity', {
      title: 'Cotton - Activity',
      google_maps_api_key: config.google.maps.api_key,
      activity_id: req.params.id
    })
  else
    res.render('index', {title: 'Cotton - Home'})
);

module.exports = router
