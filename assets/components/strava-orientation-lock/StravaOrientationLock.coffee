StravaOrientationLock = Polymer({
  is: 'strava-orientation-lock'
	
	properties:
		orientation: String

	ready: ->
    if screen.orientation.lock
      screen.orientation.lock(@orientation)
})