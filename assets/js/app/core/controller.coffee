# our base `Controller` class, this acts as a way to allow extending controllers
# to render them templates and such by specifying the template partial url
# and the containing element
class Controller

  constructor: (@id) ->
    # save a reference to our element
    @element = $ '#' + @id

    # created a deferred object for rendering incase `@render` is called before
    # the partial has been loaded and templated
    @renderDfd = whenjs.defer()

    # load our partial into a handlebars template
    @loadPartial()

  loadPartial: () ->
    success = _.bind @handleLoadPartialSuccess, @
    failure = _.bind @handleLoadPartialFailure, @
    promise = $.get "assets/js/app/partial/#{@id}.html"

    promise.then success, failure

  handleLoadPartialSuccess: (html) ->
    @template = Handlebars.compile html

    # resolve the render deferred object
    @renderDfd.resolve()

  handleLoadPartialFailure: () ->
    # oh noes, reject the render deferred object
    @renderDfd.reject()

    # and throw an error cos that partial ain't there
    throw Error "Failed to load partial #{@id}"

  render: (data) ->
    # create a reference to our actual rendering function
    render = _.bind @renderTemplate, @, data

    # wait on the render deferred object
    @renderDfd.then render, null

  renderTemplate: (data) ->
    @element.html @template data

try
  # for testing
  module.exports = Controller
catch e
  # for app
  window.Controller = Controller