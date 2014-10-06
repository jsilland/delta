Soliton.module 'Soliton.Cotton.Activity'

class Soliton.Cotton.Activity.FullScreenActivityView extends Backbone.View
  
  render: ->
    @renderTemplate(activity: @model, 'templates/activity/full_screen_activity')
