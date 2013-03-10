# `#menu-partial` controller, it handles the showing and hiding of the
# menu-partial. In the same way that `LoaderPartialController` is bound to
# `#loader-partial`, this happens here too as it's a single controller for a
# single DOM element
class MenuPartialController
  @inject = ['MenuService']
  element = $ '#menu-partial'

  constructor: (@menuService) ->
    # let's loud our menu
    @loadMenu()

  loadMenu: () ->
    success = _.bind @handleLoadMenuSuccess, @
    failure = _.bind @handleLoadMenuFailure, @
    promise = @menuService.get()

    promise.then success, failure

  handleLoadMenuSuccess: (items) ->
    console.log items

  handleLoadMenuFailure: () ->
    throw new Error 'Failed to load menu items'

app.module 'MenuPartialController', MenuPartialController