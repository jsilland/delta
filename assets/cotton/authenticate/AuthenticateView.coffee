Soliton.module 'Soliton.Cotton.Authenticate'

class Soliton.Cotton.Authenticate.AuthenticateView extends Backbone.View

  el: 'body'
  events:
    'click #authenticate': 'authenticate'
  template: ''
  
  render: ->
    @renderTemplate(undefined, 'templates/authenticate/authenticate')
    
  authenticate: ->
    window.location = "https://www.strava.com/oauth/authorize?approval_prompt=force&client_id=107&redirect_uri=http%3A%2F%2Flocalhost%3A1337%2Fstrava%2Fexchange&scope=view_private&response_type=code"
