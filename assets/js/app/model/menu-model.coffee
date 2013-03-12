class MenuModel extends Model

  add: (response) ->
    data = response.menu
    rename = _.bind @setItemName, @

    _.each data, (parent) ->
      rename parent

      if parent.children
        _.each parent.children, (child) ->
          rename child

    super data

  setItemName: (item) ->
    item.name = item.title.toLowerCase().replace /\W/g, '-'

app.module 'MenuModel', MenuModel