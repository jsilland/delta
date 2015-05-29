StravaDistanceLabel = Polymer({
  is: 'strava-distance-label'
	
	properties:
		distance:
      type: Number
      notify: true
      observer: 'distanceChanged'
    formattedDistance: String

	distanceChanged: (newValue) ->
    if newValue? && newValue != NaN
      @formattedDistance = newValue.toFixed(1)
})