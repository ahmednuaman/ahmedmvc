class MenuView extends View
  @inject = [
    'StateManager'
  ]

  constructor: (@stateManager) ->
    super('menu')

  handleRendered: () ->
    # menu's rendered, create a reference to all the `<a>` tags
    @links = @element.find('a').toArray()

    # and make them all jquery objects
    for link in @links
      @links[_i] = $ link

    # let's set up location listener to determine which one is
    # selected when the url changes
    update = _.bind @stateUpdate, @
    regex = '^section?\/?([^\/]+)?\/?'

    @stateManager.registerState regex, update, false

  stateUpdate: (path) ->
    # select menu item(s) depending on the current state
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