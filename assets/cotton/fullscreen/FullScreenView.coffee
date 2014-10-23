Soliton.module 'Soliton.Cotton.FullScreen'

class Soliton.Cotton.FullScreen.FullScreenView extends Backbone.View

  el: '#full-screen'
  
  splash: ->
    @empty()
    @renderTemplate({}, 'templates/fullscreen/splash')
    @$el.css('z-index': '2')
    @$el.fadeTo(2000, 1)
    
  discard: ->
    @$el.fadeTo(2000, 0, () =>
      @$el.css('z-index': '-1')
      @empty()
    )

  empty: ->
    @$el.empty()