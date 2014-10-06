Soliton.module 'Soliton.Cotton.Feed'

class Soliton.Cotton.Feed.FollowingActivitiesView extends Backbone.View

  el: '#feed-interesting'
  
  render: ->
    @renderTemplate({header: 'following', activities: @collection}, 'templates/feed/following_activities')
    for activity in @collection.models.filter((activity) => activity.isInteresting() && activity.get('athlete').id != @model.get('id'))
      new Soliton.Cotton.Feed.FollowingActivityView(model: activity, el: "#activity_#{activity.get('id')}").render()