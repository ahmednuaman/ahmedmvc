class SubsectionPartialController extends Controller
  @inject = [
    'SubsectionPartialView'
  ]

  constructor: (view) ->
    super(view)

app.module 'SubsectionPartialController', SubsectionPartialController