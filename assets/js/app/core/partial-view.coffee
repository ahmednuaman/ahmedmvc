class PartialView extends View

  constructor: (id, controller) ->
    super(id, controller)

  render: (dfd) ->
    @renderDfd = whenjs.defer()
    render = _.bind @renderTemplate, @, dfd

    @renderDfd.then render, null
    @loadPartial()

  renderTemplate: (dfd) ->
    @element = $ @template @data

    dfd.resolve()

try
  module.exports = PartialView
catch e
  window.PartialView = PartialView