# `MenuService` acts as a middle (wo)man between a `controller` and a `model`
class MenuService
  @inject = ['MenuModel']

  constructor: (@menuModel) ->

  get: () ->
    dfd = whenjs.defer()
    success = _.bind @getSuccess, @, dfd
    failure = _.bind @getFailure, @, dfd
    promise = $.getJSON 'mock/menu.json'

    promise.then success, failure

    dfd.promise

  getSuccess: (dfd, response) ->
    dfd.resolve response

  getFailure: (dfd) ->
    dfd.reject()

app.module 'MenuService', MenuService