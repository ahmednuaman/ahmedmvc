class MenuView extends View
  @inject = [
    'StateManager'
  ]

  constructor: (@stateManager) ->
    super('menu')

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