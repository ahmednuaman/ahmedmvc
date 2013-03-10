# our `StateManager` handles all URL changes and listeners
class StateManager
  # create an empty object to store our states
  states = []
  statesCallback = {}
  statesCancels = {}
  statesRegex = {}

  constructor: () ->
    # set up generic listener to listen to onhashchange events
    @listenToHashChange()

  listenToHashChange: () ->
    change = _.bind @handleHashChange, @

    # now if `window.onhashchange` isn't available then we shim it by firing an
    # `onhashchange` event when a link is clicked; this is done in
    # `Controller.renderTemplate()`
    window.onhashchange = change

  handleHashChange: () ->
    # run our new url via our registered states in order to handle their
    # callbacks such as loading the next/previous view
    @hash = window.location.hash.replace '#/', ''

    # go through our states array in order and see if we can haz a match
    for state in states
      regex = statesRegex[state]
      matches = @hash.match regex

      # can haz match?
      if matches?
        # we're in business, check if we need to cancel any further look ups
        # and fire the callback
        callback = statesCallback[state]
        callback.apply @, matches

        if statesCancels[state]?
          return

  registerState: (stateRegex, callback, cancels=true) ->
    # check that such state hasn't already been registered
    if statesCallback[stateRegex]?
      throw Error "State #{stateRegex} already registered with StateManager"

    # otherwise add it to our states objects; the reason why we have two is so
    # that we can compile the regex one time rather than having to do it every
    # time the state changes
    statesCallback[stateRegex] = callback
    statesRegex[stateRegex] = new RegExp stateRegex, 'gi'

    # we provide an optional argument on whether this callback should cancel the
    # look up of any further state callbacks, this is useful because we may not
    # want to load several views but we may want to update a menu when a view
    # has loaded
    statesCancels[stateRegex] = cancels

    # and finally add the state to our states array to keep a note of the
    # execution order, remember that backward loops are the fastest
    states.unshift stateRegex

app.module 'StateManager', StateManager