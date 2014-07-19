express = require('express')
router = express.Router()

router.get('/', (req, res) ->
  if req.cookies.strava_token
    res.render('index', { title: 'Express' })
  else
    res.render('authenticate', {title: 'Authenticate'})
);

module.exports = router
