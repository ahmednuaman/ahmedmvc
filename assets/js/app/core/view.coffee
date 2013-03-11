# our base `View` class, this acts as a way to allow extending controllers
# to render them templates and such by specifying the template partial url
# and the containing element
class View

  constructor: (@id) ->

  render: (data, dfd=null) ->
    # save a reference to our element
    @element = $ '#' + @id

    # created a deferred object for rendering incase `@render` is called before
    # the partial has been loaded and templated
    @renderDfd = whenjs.defer()

    # we can choose to send our own deferred object to the render function
    # incase we want to know when the rendering has been done
    # create a reference to our actual rendering function
    render = _.bind @renderTemplate, @, data, dfd

    # wait on the render deferred object
    @renderDfd.then render, null

    # load our partial
    @loadPartial()

  loadPartial: () ->
    # load our partial into a handlebars template
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

  renderTemplate: (data, dfd) ->
    @html = @template data
    @element.html @html

    # if a deferred object has been sent then resolve its ass
    if dfd?
      dfd.resolve @html

try
  # for testing
  module.exports = View
catch e
  # for app
  window.View = View