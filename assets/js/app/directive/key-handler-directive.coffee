class KeyHandler

  constructor: () ->

  directive: () ->
    attrs = 'onkeydown="keyHandler.keyDown(event)" data-key-handler'

    new Handlebars.SafeString attrs

  keyDown: (event) ->
    element = $ event.currentTarget

    switch event.keyCode
      when 38, 29460
        direction = 'up'

      when 40, 29461
        direction = 'down'

      when 37, 4
        direction = 'left'

      when 39, 5
        direction = 'right'

      when 13, 29443
        return element.click()

    @moveFocus element, direction

  moveFocus: (element, direction) ->
    index = Number element.attr 'data-col'
    target = element.attr 'data-key-' + direction
    console.log target
    dynamic = target.indexOf('!') is 0

    if dynamic
      target = target.replace '!', ''
      target = target.split '#'
      direction = target[0]
      parent = $ '#' + target[1]

      parentIndex = Number parent.attr 'data-index'

      parents = $ 'div.focus-parent'
      parentsLength = parents.length - 1

      if direction is 'leaveUp'
        parentIndex--

      else if direction is 'leaveDown'
        parentIndex++

      if parentIndex < 0
        parentIndex = parentsLength

      else if parentIndex > parentsLength
        parentIndex = 0

      parent = parents[parentIndex]

      keyHandlers = $ 'a[data-key-handler]', parent
      keyHandlersLength = keyHandlers.length - 1

      if index > keyHandlersLength
        index = keyHandlersLength

      keyHandler = keyHandlers[index]
      keyHandler.focus()

    else
      target = $ target
      target.focus()

try
  module.exports = KeyHandler
catch e
  window.keyHandler = new KeyHandler()
  Handlebars.registerHelper 'keyHandler', keyHandler.directive