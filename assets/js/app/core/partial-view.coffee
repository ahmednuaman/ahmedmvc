class PartialView extends View

  constructor: (id) ->
    super(id)

  render: (dfd) ->
    @renderDfd = whenjs.defer()
    render = _.bind @renderTemplate, @, dfd

    @renderDfd.then render, null
    @loadPartial()

  renderTemplate: (dfd) ->
    @html = @template()

    dfd.resolve @html

try
  module.exports = PartialView
catch e
  window.PartialView = PartialView