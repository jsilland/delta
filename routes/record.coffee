express = require('express')
config = require('../config/google_maps')

router = express.Router()

router.get('/', (req, res) ->
  res.render('record', {
    google_maps_api_key: config.google.maps.api_key
  })
)

module.exports = router
