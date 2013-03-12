class LoaderView
  constructor: () ->
    @element = $ '#loader'

  hide: () ->
    @element.hide()

  show: () ->
    @element.show()

app.module 'LoaderView', LoaderView