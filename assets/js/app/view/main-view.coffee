class MainView
  @inject = [
    'StateManager'
    'LoaderView'
  ]

  constructor: (@stateManager, @loaderView) ->
    @element = $ '#main'

    @addRoutes()

  addRoutes: () ->
    @addRoute '^$', 'HomePartialView'
    @addRoute '^section/([^\/]+)/$', 'SectionPartialView'
    @addRoute '^section/([^\/]+)/([^\/]+)/$', 'SubsectionPartialView'

    @stateManager.invoke()

  addRoute: (regex, view) ->
    callback = _.bind @handleRoute, @, view

    @stateManager.registerState regex, callback

  handleRoute: (view) ->
    view = app.injector.getModule view
    renderComplete = _.bind @handleRouteRenderComplete, @, view
    dfd = whenjs.defer()

    @loaderView.show()

    dfd.then renderComplete, null
    view.render dfd

  handleRouteRenderComplete: (view) ->
    @element.empty().append view.element

    @loaderView.hide()

app.module 'MainView', MainView