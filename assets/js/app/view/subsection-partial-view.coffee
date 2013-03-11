# `#subsection-partial` view extends `PartialView` as it'll be added to
# the DOM by `MainPartialView`
class SubsectionPartialView extends PartialView

  constructor: () ->
    super('subsection-partial')

app.module 'SubsectionPartialView', SubsectionPartialView