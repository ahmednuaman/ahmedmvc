class View
  constructor: (@id, @controller) ->

  render: (dfd) ->
    @element = $ '#' + @id
    @renderDfd = whenjs.defer()
    render = _.bind @renderTemplate, @, dfd

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

  renderTemplate: (dfd) ->
    @html = @template @data
    @element.html @html

    if !window.hashashchange
      as = $ 'a[href^="#"]', @element

      as.click (event) ->
        a = $ this
        hash = a.attr('href').split('#')[1]

        window.location.hash = hash

        window.onhashchange()

        false

    dfd.resolve()

  remove: () ->
    @element.remove()

try
  module.exports = View
catch e
  window.View = View