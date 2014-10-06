Soliton.module 'Soliton.Cotton.Feed'

class Soliton.Cotton.Feed.FeedController
  
  constructor: ->
    @currentAthlete = new Soliton.Cotton.Models.CurrentAthlete()
    @currentAthlete.fetch(
      reset: true
      success: (model, response, options) ->
        @followingActivities = new Soliton.Cotton.Models.FollowingActivities()
        @followingActivities.setPageSize(50)
        @followingActivities.fetch(
          reset: true
          success: (collection, response, options) ->
            new Soliton.Cotton.Feed.FollowingActivitiesView(collection: collection, model: model).render()
            new Soliton.Cotton.Feed.OtherActivitiesView(collection: collection, model: model).render()
        )
        
        @athleteActivities = new Soliton.Cotton.Models.AthleteActivities()
        @athleteActivities.setPageSize(28)
        @athleteActivities.fetch(
          reset: true
          success: (collection, response, options) ->
            new Soliton.Cotton.Feed.AthleteActivitiesView(collection: collection, model: model).render()
        )
    )
  
