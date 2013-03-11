class HomePartialController extends Controller
  @inject = [
    'HomePartialView'
  ]

  constructor: (view) ->
    super(view)

app.module 'HomePartialController', HomePartialController