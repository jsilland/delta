Soliton.module 'Soliton.Cotton.Feed'

class Soliton.Cotton.Feed.FollowingActivityView extends Backbone.View
  
  render: ->
    @renderTemplate(activity: @model, 'templates/feed/following_activity')
