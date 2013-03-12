class LoaderView
  element = $ '#loader'

  constructor: () ->

  hide: () ->
    element.hide()

  show: () ->
    element.show()

app.module 'LoaderView', LoaderView