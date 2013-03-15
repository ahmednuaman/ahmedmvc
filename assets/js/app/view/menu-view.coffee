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
    topLinks = []

    for link in @links
      link = $ link

      if link.hasClass 'menu-parent-link'
        topLinks.push link

    @links = topLinks
    @links[0].focus()

    update = _.bind @stateUpdate, @
    regex = '^section?\/?([^\/]+)?\/?'

    @stateManager.registerState regex, update, false

  stateUpdate: (path) ->
    updateClass = _.bind @updateClass, @, path

    for link in @links
      updateClass link

  updateClass: (path, link) ->
    hashIndex = link.attr('href').indexOf(path)
    child = @element.find '#' + link.parent().attr('id') + '-children'

    if hashIndex isnt -1 and path.length > 1
      keyHandlers = child.find('a[data-key-handler]').length - 1

      child.attr('data-children', keyHandlers).addClass 'selected'

    else
      child.removeClass 'selected'

app.module 'MenuView', MenuView