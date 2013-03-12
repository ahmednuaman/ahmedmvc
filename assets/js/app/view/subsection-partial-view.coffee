class SubsectionPartialView extends PartialView
  @inject = [
    'SubsectionPartialController'
  ]

  constructor: (subsectionPartialController) ->
    super 'subsection-partial', subsectionPartialController

app.module 'SubsectionPartialView', SubsectionPartialView