Soliton.module 'Soliton.Cotton.Models'

class Soliton.Cotton.Models.FollowingActivities extends Backbone.PageableCollection
  
  model: Soliton.Cotton.Models.Activity
  url: "/strava/activities/following"