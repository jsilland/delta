Soliton.module 'Soliton.Cotton.Models'

class Soliton.Cotton.Models.LatLngStream extends Backbone.Model
  
  url: ->
    "/strava/activities/#{@id}/streams/latlng"
    
  parse: (response, options) ->
    response[0]