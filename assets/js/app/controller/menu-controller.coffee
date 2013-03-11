class MenuController extends Controller
  @inject = [
    'MenuView'
    'MenuService'
  ]

  constructor: (@view, @menuService) ->
    # let's loud our menu
    @loadMenu()

  loadMenu: () ->
    success = _.bind @handleLoadMenuSuccess, @
    failure = _.bind @handleLoadMenuFailure, @
    promise = @menuService.get()

    promise.then success, failure

  handleLoadMenuSuccess: (items) ->
    # create a deferred object so we know when rendering is complete
    dfd = whenjs.defer()
    success = _.bind @view.handleRendered, @view
    data =
      items: items

    dfd.then success, null

    @view.render data, dfd

  handleLoadMenuFailure: () ->
    throw new Error 'Failed to load menu items'

app.module 'MenuController', MenuController