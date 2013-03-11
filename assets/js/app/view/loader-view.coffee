# `#loader-partial` view, it handles the showing and hiding of the loader-partial. In this case the loader-partial is
# static so we're happy to init the view with a reference to the DOM element.
class LoaderView
  # specify a DOM element that this class is responsible for so it turns out that `#id` is **faster** than `div#id`;
  # check out the test on [abilities](http://ab.iliti.es)
  element = $ '#loader'

  constructor: () ->

  hide: () ->
    element.hide()

  show: () ->
    element.show()

app.module 'LoaderView', LoaderView