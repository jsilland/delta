Strava.module('Strava.Common').OrientationLock = Polymer({
  is: 'strava-orientation-lock'
	
	properties:
		orientation: String

	ready: ->
    if screen.orientation && screen.orientation.lock
      screen.orientation.lock(@orientation).catch(
        (e) ->
          console.log("Failed to lock screen orientation: #{e}")
      )
})