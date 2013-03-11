# `#main-partial` view handles the adding and removing of views and their
# views from the `#main-partial` DOM element; it uses `StateManager` to
# route any stage changes according to the routes set out herein
class MainView
  @inject = [
    'LoaderView'
  ]

  # ref our DOM element
  element = $ '#main'

  constructor: (@loaderView) ->

  beforeRender: () ->
    @loaderView.show()

  render: (view) ->
    # add the html to the DOM
    element.html view.html

    @loaderView.hide()

app.module 'MainView', MainView