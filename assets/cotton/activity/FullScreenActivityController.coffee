Soliton.module 'Soliton.Cotton.Activity'

class Soliton.Cotton.Activity.FullScreenActivityController
  
  constructor: (activityId)->
    new Soliton.Cotton.FullScreen.FullScreenView().splash()
    @activity = new Soliton.Cotton.Models.Activity(id: activityId)
    @activity.fetch(
      reset: true
      success: (model, response, options) ->
        document.title = model.get('title')
        window.history.pushState(undefined, undefined, "/activities/#{activityId}")
        new Soliton.Cotton.FullScreen.FullScreenView().empty()
        new Soliton.Cotton.Activity.FullScreenActivityView(model: model).render()
    )  
