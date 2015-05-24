StravaTimeLabel = Polymer({
  is: 'strava-time-label'
	
	properties:
		elapsedtime:
      type: Number
      notify: true
      observer: 'timeChanged'
    formattedTime: String

	timeChanged: (newValue) ->
    @formattedTime = @format(newValue)
    
  format: (time) ->
    "#{@formatHours(time)}:#{@formatMinutes(time)}:#{@formatSeconds(time)}"
  
  formatHours: (time) ->
    @pad(Math.floor(time / 3600))
  
  formatMinutes: (time) ->
    @pad(Math.floor((time % 3600) / 60))
    
  formatSeconds: (time) ->
    @pad((time % 3600) % 60)
  
  pad: (value) ->
    if value < 10
      "0#{value}"
    else
      "#{value}"
})