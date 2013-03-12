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
  module.exports = Controller
catch e
  window.Controller = Controller