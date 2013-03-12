class KeyHandler

  constructor: () ->

  directive: (top, right, bottom, left) ->
    attrs = """
      data-key-top="#{top}"
      data-key-right="#{right}"
      data-key-bottom="#{bottom}"
      data-key-left="#{left}"
      onkeydown="keyHandler.keyDown(event)"
    """

    new Handlebars.SafeString attrs

  keyDown: (event) ->


try
  module.exports = KeyHandler
catch e
  window.keyHandler = new KeyHandler()
  Handlebars.registerHelper 'keyHandler', keyHandler.directive