class MenuView extends View
  @inject = [
    'StateManager'
    'MenuController'
  ]

  constructor: (@stateManager, menuController) ->
    super 'menu', menuController

    @loadMenuData()

  loadMenuData: () ->
    dfd = whenjs.defer()
    success = _.bind @handleMenuData, @

    dfd.then success, null
    @controller.loadMenu dfd

  handleMenuData: (items) ->
    dfd = whenjs.defer()
    success = _.bind @handleRendered, @
    @data =
      items: items

    dfd.then success, null
    @render dfd

  handleRendered: () ->
    @links = @element.find('a').toArray()

    for link in @links
      @links[_i] = $ link

    update = _.bind @stateUpdate, @
    regex = '^section?\/?([^\/]+)?\/?'

    @stateManager.registerState regex, update, false

  stateUpdate: (path) ->
    updateClass = _.bind @updateClass, @, path

    for link in @links
      updateClass link

  updateClass: (path, link) ->
    hashIndex = link.attr('href').indexOf(path)

    if hashIndex isnt -1 and path.length > 1
      link.parent().addClass 'selected'

    else
      link.parent().removeClass 'selected'

app.module 'MenuView', MenuView