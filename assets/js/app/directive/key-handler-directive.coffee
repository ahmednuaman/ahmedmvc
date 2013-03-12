class KeyHandler

  constructor: () ->

  directive: () ->
    attrs = 'onkeydown="keyHandler.keyDown(event)"'

    new Handlebars.SafeString attrs

  keyDown: (event) ->
    console.log event

try
  module.exports = KeyHandler
catch e
  window.keyHandler = new KeyHandler()
  Handlebars.registerHelper 'keyHandler', keyHandler.directive