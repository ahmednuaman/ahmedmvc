# `#main-partial` controller handles the adding and removing of views and their
# controllers from the `#main-partial` DOM element; it uses `StateManager` to
# route any stage changes according to the routes set out herein
class MainPartialController
  @inject = [
    'StateManager'
    'LoaderPartialController'
  ]

  # create an empty routes object
  routes = {}

  # ref our DOM element
  element = $ '#main-partial'

  constructor: (@stateManager, @loaderPartialController) ->
    # set up our routes
    @addRoutes()

  addRoutes: () ->
    # add a route by calling `@addRoute` and passing a regex for the path and
    # the controller to add to the DOM when route is handled
    @addRoute '^$', 'HomePartialController'
    @addRoute '^section/([^\/]+)/$', 'SectionPartialController'
    @addRoute '^section/([^\/]+)/([^\/]+)/$', 'SubsectionPartialController'

    # finally invoke the `StateManager`
    @stateManager.invoke()

  addRoute: (regex, controller) ->
    # create a callback for this regex and controller
    callback = _.bind @handleRoute, @, controller

    # add route to our `StateManager`, it cancels remember
    @stateManager.registerState regex, callback

  handleRoute: (controller) ->
    # get the controller from our injector
    controller = app.injector.getModule controller

    # create a deferred object for when our controller has rendered and is ready
    # to be added to the DOM
    rendered = _.bind @handleRouteRendered, @, controller
    dfd = whenjs.defer()

    dfd.then rendered, null

    # render!
    controller.render dfd

  handleRouteRendered: (controller) ->
    # add the controller to the DOM
    element.html controller.html

    # hide the loader
    @loaderPartialController.hide()

app.module 'MainPartialController', MainPartialController