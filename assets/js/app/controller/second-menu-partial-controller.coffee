# `#second-menu-partial` Controller
class SecondMenuPartialController extends Controller
  @inject = [
    'SecondMenuService'
  ]

  constructor: (@secondMenuService) ->
    super('second-menu-partial')

    # let's render our menu
    dfd = whenjs.defer()
    success = _.bind @handleRendered, @
    data = @secondMenuService.get()

    dfd.then success, null

    @render data, dfd

  handleRendered: () ->
    console.log 'yay'

app.module 'SecondMenuPartialController', SecondMenuPartialController