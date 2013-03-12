class MainView
  @inject = [
    'LoaderView'
  ]

  element = $ '#main'

  constructor: (@loaderView) ->

  beforeRender: () ->
    @loaderView.show()

  render: (view) ->
    element.html view.html

    @loaderView.hide()

app.module 'MainView', MainView