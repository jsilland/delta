#= require templates/authenticate

Soliton.module 'Soliton.Cotton'

class Soliton.Cotton.AuthenticateView extends Backbone.View

  el: 'body'
  events:
    'click #authenticate': 'authenticate'
  template: ''
    
  render:
    debugger