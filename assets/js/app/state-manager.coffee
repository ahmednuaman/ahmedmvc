class StateManager
  states = []
  statesCallback = {}
  statesRegex = {}

  constructor: () ->
    @listenToHashChange()

  listenToHashChange: () ->
    change = _.bind @handleHashChange, @

    window.hashashchange = window['onhashchange']?

    window.onhashchange = change

  handleHashChange: () ->
    @hash = window.location.hash.replace '#/', ''

    for state in states
      regex = statesRegex[state]
      matches = @hash.match regex

      if matches
        callback = statesCallback[state]
        callback.apply @, matches

  registerState: (stateRegex, callback) ->
    if statesCallback[stateRegex]?
      throw Error "State #{stateRegex} already registered with StateManager"

    statesCallback[stateRegex] = callback
    statesRegex[stateRegex] = new RegExp stateRegex, 'gi'

    states.unshift stateRegex

  invoke: () ->
    @handleHashChange()

app.module 'StateManager', StateManager