Soliton.module 'Soliton.Cotton.Feed'

class Soliton.Cotton.Feed.AthleteActivitiesView extends Backbone.View

  el: '#feed-athlete'
  events:
    'click .athlete-activity': 'openActivity'
  
  render: ->
    @renderTemplate({header: 'me', activities: @collection, athlete: @model}, 'templates/feed/athlete_activities')
    for activity in @collection.models
      new Soliton.Cotton.Feed.AthleteActivityView(model: activity, el: "#activity_#{activity.get('id')}").render()
  
  openActivity: (event) ->
    target = jQuery(event.target)
    activityId = target.closest('li').attr('id').substring(9)
    activityId = parseInt(activityId)
    new Soliton.Cotton.Activity.FullScreenActivityController(activityId)