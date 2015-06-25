Strava.module('Strava.Record').DistanceLabel = Polymer({
  is: 'strava-record-distance-label'
	
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