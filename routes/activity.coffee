express = require('express')
config = require('../config/google_maps')

router = express.Router()

router.get('/:id', (req, res) ->
  res.render('activity', {
    google_maps_api_key: config.google.maps.api_key
    id: req.params.id
  })
)

module.exports = router
