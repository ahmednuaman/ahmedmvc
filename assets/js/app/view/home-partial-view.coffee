class HomePartialView extends PartialView
  @inject = [
    'HomePartialController'
  ]

  constructor: (homePartialController) ->
    super 'home-partial', homePartialController

app.module 'HomePartialView', HomePartialView