# `MenuModel` it always extends the base class `Model`
class MenuModel extends Model

  constructor: () ->
    super()

  add: (response) ->
    # before we add the `response.menu` array to our model we need to create
    # names for each entry
    data = response.menu
    rename = _.bind @setItemName, @

    # loop through the parents and children
    _.each data, (parent) ->
      rename parent

      if parent.children?
        _.each parent.children, (child) ->
          rename child

    # save the data
    super data

  setItemName: (item) ->
    item.name = item.title.toLowerCase().replace /\W/g, '-'

app.module 'MenuModel', MenuModel