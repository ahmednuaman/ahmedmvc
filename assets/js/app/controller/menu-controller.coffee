class MenuController extends Controller
  @inject = [
    'MenuService'
  ]

  constructor: (@menuService) ->

  loadMenu: (dfd) ->
    success = _.bind @handleLoadMenuSuccess, @, dfd
    failure = _.bind @handleLoadMenuFailure, @, dfd
    promise = @menuService.get()

    promise.then success, failure

  handleLoadMenuSuccess: (dfd, items) ->
    dfd.resolve items

  handleLoadMenuFailure: () ->
    throw new Error 'Failed to load menu items'

app.module 'MenuController', MenuController