Soliton.module 'Soliton.Cotton.Feed'

class Soliton.Cotton.Feed.AthleteActivityView extends Backbone.View
  
  render: ->
    @renderTemplate(activity: @model, 'templates/feed/athlete_activity')