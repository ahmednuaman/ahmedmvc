# our `ViewController` extends our base `Controller` and is used for views that
# will get rendered within our main view partial
class ViewController extends Controller

  constructor: (id) ->
    super(id)

  render: (dfd) ->
    # here we're overwriting `Controller.render()` so that instead
    # of rendering itself and adding the html to its own element
    # we're going to sort out our data, load our partial and then
    # return the html for the `MainPartialController` to handle, so
    # first we create our new deferred object
    @renderDfd = whenjs.defer()
    render = _.bind @renderTemplate, @, dfd

    @renderDfd.then render, null

    # load the partial!
    @loadPartial()

  renderTemplate: (dfd) ->
    @html = @template()

    # resolve the deferred object
    dfd.resolve()

try
  # for testing
  module.exports = ViewController
catch e
  # for app
  window.ViewController = ViewController