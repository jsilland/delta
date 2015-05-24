StravaSplash = Polymer({
  is: 'strava-splash'
	
	properties:
		photo: String

	ready: ->
    @$.background.style.backgroundImage = "url('#{@photo}')"
})