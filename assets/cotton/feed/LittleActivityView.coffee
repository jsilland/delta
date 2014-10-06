Soliton.module 'Soliton.Cotton.Feed'

class Soliton.Cotton.Feed.LittleActivityView extends Backbone.View
  
  render: ->
    @renderTemplate(activity: @model, 'templates/feed/little_activity')
