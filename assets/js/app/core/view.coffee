class View
  constructor: (@id) ->

  render: (data, dfd=null) ->
    @element = $ '#' + @id
    @renderDfd = whenjs.defer()
    render = _.bind @renderTemplate, @, data, dfd

    @renderDfd.then render, null
    @loadPartial()

  loadPartial: () ->
    success = _.bind @handleLoadPartialSuccess, @
    failure = _.bind @handleLoadPartialFailure, @
    promise = $.get "assets/js/app/partial/#{@id}.html"

    promise.then success, failure

  handleLoadPartialSuccess: (html) ->
    @template = Handlebars.compile html

    @renderDfd.resolve()

  handleLoadPartialFailure: () ->
    @renderDfd.reject()

    throw Error "Failed to load partial #{@id}"

  renderTemplate: (data, dfd) ->
    @html = @template data
    @element.html @html

    dfd.resolve @html

try
  module.exports = View
catch e
  window.View = View