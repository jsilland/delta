StravaPhotoButton = Polymer({
  is: 'strava-photo-button'

  ready: ->
    @$['photo-button'].addEventListener('click', (e) => @$['file-selector'].click())
    @$['file-selector'].onchange = (event) => @newFile(event)
    
  newFile: (event) ->
    files = event.target.files
    if files && files.length > 0
      console.log(files[0])
})