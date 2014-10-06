Soliton.module 'Soliton.Cotton.Feed'

class Soliton.Cotton.Feed.CurrentAthleteView extends Backbone.View

  el: 'body'
  
  render: ->
    @renderTemplate(athlete: @model, 'templates/feed/current_athlete')
