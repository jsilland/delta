_.extend(Backbone.View.prototype, {
  $$: (selector)->
    use_selector = if selector then selector else @el
    jQuery(use_selector)

  $document: ->
    jQuery(document)

  getTemplateFor: (template) ->
    template = @template unless template
    if jQuery.isFunction(template) then template else HAML[template]

  renderTemplate: (data, template) ->
    useTemplate = @getTemplateFor(template)
    @$el.html(useTemplate(data))
})

Cotton.initializeTemplates = ->
  _.templateSettings = {
    interpolate : /\{-(.+?)-\}/g,
    evaluate : /<%([\s\S]+?)%>/g,
    autoEscape : /\{\{(.+?)\}\}/g
  }

Cotton.initializeTemplates()
