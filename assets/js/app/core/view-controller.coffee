# our `ViewController` extends our base `Controller` and is used for views that
# will get rendered within our main view partial
class ViewController extends Controller

  constructor: (id) ->
    super(id)

try
  # for testing
  module.exports = ViewController
catch e
  # for app
  window.ViewController = ViewController