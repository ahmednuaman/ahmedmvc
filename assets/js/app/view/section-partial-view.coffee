# `#section-partial` view extends `PartialView` as it'll be added to
# the DOM by `MainPartialView`
class SectionPartialView extends PartialView

  constructor: () ->
    super('section-partial')

app.module 'SectionPartialView', SectionPartialView