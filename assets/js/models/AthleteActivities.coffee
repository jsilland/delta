Soliton.module 'Soliton.Cotton.Models'

class Soliton.Cotton.Models.AthleteActivities extends Backbone.PageableCollection
  
  model: Soliton.Cotton.Models.Activity
  url: "/strava/athlete/activities"