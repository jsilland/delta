StravaDistanceLabel = Polymer({
  is: 'strava-distance-label'
	
	properties:
		distance:
      type: Number
      notify: true
      observer: 'distanceChanged'
    formattedDistance: String

	distanceChanged: (newValue) ->
    if newValue?
      @formattedDistance = newValue.toFixed(1)
})