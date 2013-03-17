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
        element.click()

        return false

    if direction
      @moveFocus element, direction

    false

  moveFocus: (element, direction) ->
    target = element.attr 'data-key-' + direction
    dynamic = target.indexOf('!') is 0

    if dynamic
      target = target.replace '!', ''
      target = target.split '#'
      direction = target[0]
      parent = $ '#' + target[1]

      index = Number element.attr 'data-col'
      parentIndex = Number parent.attr 'data-index'
      parents = $ 'div.focus-parent'
      parentsLength = parents.length - 1

      @findKeyHandler direction, index, parentIndex, parents, parentsLength

    else
      target = $ target
      target.focus()

  findKeyHandler: (direction, index, parentIndex, parents, parentsLength) ->
    if direction is 'leaveUp'
      parentIndex--

    else if direction is 'leaveDown'
      parentIndex++

    if parentIndex < 0
      parentIndex = parentsLength

    else if parentIndex > parentsLength
      parentIndex = 0

    parent = $ parents[parentIndex]

    keyHandlers = $ 'a[data-key-handler]:visible', parent

    if keyHandlers.length
      keyHandlersLength = keyHandlers.length - 1

      if index > keyHandlersLength
        index = keyHandlersLength

      keyHandler = $ keyHandlers[index]

      if keyHandler.is ':visible'
        return keyHandler.focus()

    @findKeyHandler direction, index, parentIndex, parents, parentsLength

try
  module.exports = KeyHandler
catch e
  window.keyHandler = new KeyHandler()
  Handlebars.registerHelper 'keyHandler', keyHandler.directive