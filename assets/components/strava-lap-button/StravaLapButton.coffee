StravaLapButton = Polymer({
  is: 'strava-lap-button'
  
  properties:
    currentPosition:
      type: Object
    recordingLap:
      type: Boolean
      value: false
      observer: 'recordingLapChanged'
    enabled:
      type: Boolean
      value: false
      observer: 'enabledChanged'
  
  created: ->
    @laps = []

  ready: ->
    @$['lap-button'].addEventListener('click', => @lapButtonClicked())

  enabledChanged: (newValue) ->
    if newValue
      @$['lap-button'].removeAttribute('disabled')
    else
      @$['lap-button'].setAttribute('disabled', 'true')

  lapButtonClicked: ->
    @recordingLap = !@recordingLap

  recordingLapChanged: (newValue) ->
    if newValue && @currentPosition?
      console.log("Starting lap: " + JSON.stringify(@currentPosition))
      @currentLap = [@currentPosition]
      @$['lap-image'].src = '/assets/images/lap/lap-ongoing.svg'
    else if @currentPosition?
      console.log("Stopping lap: " + JSON.stringify(@currentPosition))
      @currentLap.push(@currentPosition)
      @laps.push(@currentLap)
      @$['lap-image'].src = '/assets/images/lap/lap.svg'
})