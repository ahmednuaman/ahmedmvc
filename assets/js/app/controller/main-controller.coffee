class MainController
  @inject = [
    'MainView'
    'StateManager'
  ]

  routes = {}

  constructor: (@view, @stateManager) ->
    @addRoutes()

  addRoutes: () ->
    @addRoute '^$', 'HomePartialController'
    @addRoute '^section/([^\/]+)/$', 'SectionPartialController'
    @addRoute '^section/([^\/]+)/([^\/]+)/$', 'SubsectionPartialController'

    @stateManager.invoke()

  addRoute: (regex, controller) ->
    callback = _.bind @handleRoute, @, controller

    @stateManager.registerState regex, callback

  handleRoute: (controller) ->
    controller = app.injector.getModule controller
    initComplete = _.bind @view.render, @view, controller.view
    dfd = whenjs.defer()

    dfd.then initComplete, null

    @view.beforeRender()

    controller.init dfd

app.module 'MainController', MainController