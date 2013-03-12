class App

  constructor: (@injector) ->

  module: (name, klass) ->
    klass = @injector.process name, klass

    @injector.register name, klass

try
  module.exports = App
catch e
  window.app = new App injector
