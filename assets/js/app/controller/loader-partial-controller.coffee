# `#loader-partial` controller, it handles the showing and hiding of the
# loader-partial
class LoaderPartialController
  # specify a DOM element that this class is responsible for
  # so it turns out that `#id` is **faster** than `div#id`; check out the test
  # on [abilities](http://ab.iliti.es)
  element = $ '#loader-partial'

  constructor: () ->

  hide: () ->
    element.hide()

  show: () ->
    element.show()

# add it to our app
app.module 'LoaderPartialController', LoaderPartialController