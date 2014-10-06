Soliton.module 'Soliton.Cotton.Models'

class Soliton.Cotton.Models.Activity extends Backbone.Model
  
  url: ->
    "/strava/activity/#{@id}"
  
  fullAthleteName: ->
    "#{@get('athlete').firstname} #{@get('athlete').lastname}"

  largeMapUrl: ->
    "http://maps.googleapis.com/maps/api/staticmap?key=AIzaSyCmfR2XMO4sljkBUtkxrE3aizEn9AL39zw&size=640x480&path=weight:4%7Ccolor:red%7Cenc:#{encodeURIComponent(@get('map').summary_polyline)}"

  mapUrl: ->
    "http://maps.googleapis.com/maps/api/staticmap?key=AIzaSyCmfR2XMO4sljkBUtkxrE3aizEn9AL39zw&size=640x284&path=weight:4%7Ccolor:red%7Cenc:#{encodeURIComponent(@get('map').summary_polyline)}"
    
  littleMapUrl: ->
    "http://maps.googleapis.com/maps/api/staticmap?key=AIzaSyCmfR2XMO4sljkBUtkxrE3aizEn9AL39zw&size=320x284&path=weight:4%7Ccolor:red%7Cenc:#{encodeURIComponent(@get('map').summary_polyline)}"
    
  isInteresting: ->
    lame = @get('commute') || @get('trainer') || @get('manual')
    long = (@get('type') == 'Run' && @get('distance') > 5000) || (@get('type') == 'Ride' && @get('distance') > 15000)
    !lame && long