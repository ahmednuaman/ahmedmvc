# `SecondMenuService` acts as a middle (wo)man between a `controller` and a `model`
class SecondMenuService
  @inject = ['SecondMenuModel']

  constructor: (@secondMenuModel) ->

  get: () ->
    @secondMenuModel.all()

app.module 'SecondMenuService', SecondMenuService