class SectionPartialView extends PartialView
  @inject = [
    'SectionPartialController'
  ]

  constructor: (sectionPartialController) ->
    super 'section-partial', sectionPartialController

app.module 'SectionPartialView', SectionPartialView