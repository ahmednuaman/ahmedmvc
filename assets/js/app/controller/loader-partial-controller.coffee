# `#loader-partial` controller, it handles the showing and hiding of the
# loader-partial. In this case the loader-partial is static so we're happy to
# init the controller with a reference to the DOM element.
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