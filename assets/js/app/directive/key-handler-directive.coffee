class KeyHandler

  constructor: () ->

  directive: (top, right, bottom, left, col) ->
    attrs = """
      data-key-top="#{top}"
      data-key-right="#{right}"
      data-key-bottom="#{bottom}"
      data-key-left="#{left}"
      data-col="#{col}"
      onkeydown="keyHandler.keyDown(event)"
    """

    new Handlebars.SafeString attrs

  keyDown: (event) ->
    console.log event

try
  module.exports = KeyHandler
catch e
  window.keyHandler = new KeyHandler()
  Handlebars.registerHelper 'keyHandler', keyHandler.directive