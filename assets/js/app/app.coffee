# set up our app core
class App

  constructor: (@injector) ->
    # store a ref to injector within our app, we shouldn't access it directly,
    # app will handle that shiz niz for us

  module: (name, klass) ->
    # fire up the klass by injecting its deps into it
    klass = @injector.process name, klass

    # registers a klass with our app and subsequently with our injector
    @injector.register name, klass

try
  # for test
  module.exports = App
catch e
  # fire up our app
  window.app = new App injector
