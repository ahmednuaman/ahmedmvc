# `#home-partial` controller extends `ViewController` as it'll be added to
# the DOM by `MainPartialController`
class HomePartialController extends ViewController

  constructor: () ->
    super('home-partial')

app.module 'HomePartialController', HomePartialController