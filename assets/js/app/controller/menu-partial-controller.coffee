# `#menu-partial` controller, it handles the showing and hiding of the
# menu-partial. In the same way that `LoaderPartialController` is bound to
# `#loader-partial`, this happens here too as it's a single controller for a
# single DOM element except it extends `Controller` cos we need to compile a
# template so we now pass the `id` of our DOM element to `Controller` and
# that does all the binding and templating magic for us; **note** that
# `Controller` expects the `id` to be without the leading `#` as it also expects
# there to be a partial in `assets/js/app/partial/` with the same name
class MenuPartialController extends Controller
  @inject = [
    'StateManager'
    'MenuService'
  ]

  constructor: (@stateManager, @menuService) ->
    super('menu-partial')

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
    success = _.bind @handleRendered, @
    data =
      items: items

    dfd.then success, null

    @render data, dfd

  handleLoadMenuFailure: () ->
    throw new Error 'Failed to load menu items'

  handleRendered: () ->
    # menu's rendered, create a reference to all the `<a>` tags
    @links = @element.find('a').toArray()

    # and make them all jquery objects
    for link in @links
      @links[_i] = $ link

    # let's set up location listener to determine which one is
    # selected when the url changes
    update = _.bind @stateUpdate, @
    # regex = '^section?\/?([^\/]+)?\/?([^\/]+)?\/?$'
    regex = '.*'

    @stateManager.registerState regex, update, false

  stateUpdate: () ->
    console.log arguments
    # select menu item(s) depending on the current state
    updateClass = _.bind @updateClass, @

    for link in @links
      updateClass link

  updateClass: (link) ->
    hashIndex = link.attr('href').indexOf(window.location.hash)

    if hashIndex is 0 and window.location.hash.length > 1
      link.parent().addClass 'selected'

    else
      link.parent().removeClass 'selected'

app.module 'MenuPartialController', MenuPartialController