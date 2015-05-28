StravaRecordButton = Polymer({
  is: 'strava-record-button'
  
  properties:
    enabled:
      type: Boolean
      observer: 'enabledChanged'
    recording:
      type: Boolean
      value: false
      notify: true
      observer: 'recordingChanged'

  ready: ->
    @$['record-button'].addEventListener('click', => @recordButtonClicked())

  enabledChanged: (newValue) ->
    if @recording && !newValue
      console.warn('Poor GPS signal while recording')
      return
    if newValue
      @$['record-button'].removeAttribute('disabled')
    else
      @$['record-button'].setAttribute('disabled', 'true')

  recordButtonClicked: ->
    @recording = !@recording
      
  recordingChanged: (newValue) ->
    if newValue
      @$['record-image'].src = '/assets/images/record/pause.svg'
    else
      @$['record-image'].src = '/assets/images/record/record.svg'
})