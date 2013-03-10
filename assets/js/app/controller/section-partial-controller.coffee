# `#section-partial` controller extends `ViewController` as it'll be added to
# the DOM by `MainViewController`
class SectionPartialController extends ViewController

  constructor: () ->
    super('section-partial')

app.module 'SectionPartialController', SectionPartialController