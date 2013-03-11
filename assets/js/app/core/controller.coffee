class Controller

  constructor: (@view) ->

  init: (dfd) ->
    renderDfd = whenjs.defer()
    rendered = _.bind @initComplete, @, dfd

    renderDfd.then rendered, null

    @view.render renderDfd

  initComplete: (dfd) ->
    dfd.resolve()

try
  # for testing
  module.exports = Controller
catch e
  # for app
  window.Controller = Controller