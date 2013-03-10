# `#menu-partial` controller, it handles the showing and hiding of the
# menu-partial. In the same way that `LoaderPartialController` is bound to
# `#loader-partial`, this happens here too as it's a single controller for a
# single DOM element except it extends `Controller` cos we need to compile a
# template so we now pass the `id` of our DOM element to `Controller` and
# that does all the binding and templating magic for us; **note** that
# `Controller` expects the `id` to be without the leading `#` as it also expects
# there to be a partial in `assets/js/app/partial/` with the same name
class MenuPartialController extends Controller
  @inject = ['MenuService']

  constructor: (@menuService) ->
    super('menu-partial')

    # let's loud our menu
    @loadMenu()

  loadMenu: () ->
    success = _.bind @handleLoadMenuSuccess, @
    failure = _.bind @handleLoadMenuFailure, @
    promise = @menuService.get()

    promise.then success, failure

  handleLoadMenuSuccess: (items) ->
    @render
      items: items

  handleLoadMenuFailure: () ->
    throw new Error 'Failed to load menu items'

app.module 'MenuPartialController', MenuPartialController