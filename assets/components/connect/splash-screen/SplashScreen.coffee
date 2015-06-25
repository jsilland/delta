Strava.module('Strava.Connect').SplashScreen = Polymer({
  is: 'strava-splash-screen'
	
	properties:
		photos: Array

	ready: ->
    photo = @photos[Math.floor(Math.random() * @photos.length)]
    @$.background.style.backgroundImage = "url('#{photo}')"
})