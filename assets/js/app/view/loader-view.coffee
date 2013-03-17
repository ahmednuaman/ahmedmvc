class LoaderView
  constructor: () ->
    @element = $ '#loader'

  hide: () ->
    @element.fadeOut()

  show: () ->
    @element.fadeIn()

app.module 'LoaderView', LoaderView