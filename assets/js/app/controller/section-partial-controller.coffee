class SectionPartialController extends Controller
  @inject = [
    'SectionPartialView'
  ]

  constructor: (view) ->
    super(view)

app.module 'SectionPartialController', SectionPartialController