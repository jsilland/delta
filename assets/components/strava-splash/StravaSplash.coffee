StravaSplash = Polymer({
  is: 'strava-splash'
	
	properties:
		photos: Array

	ready: ->
    photo = @photos[Math.floor(Math.random() * @photos.length)]
    @$.background.style.backgroundImage = "url('#{photo}')"
})