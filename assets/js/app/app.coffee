# set up our app core
class App

  constructor: () ->
    # set up our injector
    @setupInjector()

  setupInjector: () ->
    # store a ref to injector within our app, we shouldn't access it directly,
    # app will handle that shiz niz for us
    @injector = injector()

  controller: (name, klass) ->
    # set the class's type to controller
    klass.type = 'controller'

    # fire up the controller by injecting its deps into it
    controller = @injector.process name, klass

    # registers a controller with our app and subsequently with our injector
    @injector.register name, controller

try
  # for test
  module.export =
    App: App
catch e
  # fire up our app
  window.app = new App()
