# `#home-partial` controller extends `PartialView` as it'll be added to
# the DOM by `MainPartialView`
class HomePartialView extends PartialView

  constructor: () ->
    super('home-partial')

app.module 'HomePartialView', HomePartialView