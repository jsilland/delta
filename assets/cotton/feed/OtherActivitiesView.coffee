Soliton.module 'Soliton.Cotton.Feed'

class Soliton.Cotton.Feed.OtherActivitiesView extends Backbone.View

  el: '#feed-other'
  
  render: ->
    @renderTemplate({header: 'the small stuff', activities: @collection}, 'templates/feed/other_activities')
    for activity in @collection.models.filter((activity) => !activity.isInteresting() && activity.get('athlete').id != @model.get('id'))
      new Soliton.Cotton.Feed.LittleActivityView(model: activity, el: "#activity_#{activity.get('id')}").render()