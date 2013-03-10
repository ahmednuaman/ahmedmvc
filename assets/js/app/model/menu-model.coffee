# `MenuModel` it always extends the base class `Model`
class MenuModel extends Model

  constructor: () ->
    super()

  add: (response) ->
    super response.menu

app.module 'MenuModel', MenuModel