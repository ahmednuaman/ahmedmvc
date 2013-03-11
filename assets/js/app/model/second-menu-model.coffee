# `SecondMenuModel` it always extends the base class `Model`
class SecondMenuModel extends Model

  constructor: () ->
    super
      data: 'yeahhhhhh'

app.module 'SecondMenuModel', SecondMenuModel