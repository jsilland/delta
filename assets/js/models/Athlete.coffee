Soliton.module 'Soliton.Cotton.Models'

class Soliton.Cotton.Models.Athlete
  
  url: ->
    "/strava/athletes/#{@id}"
    
  created: ->
    new Date(@get('created_on'))
    
  fullName: ->
    "#{@get('firstname')} #{@get('lastname')}"