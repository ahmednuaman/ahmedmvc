# our base `Model` class, it acts as a collection
class Model
  # keep a _private_ reference to this model's items
  items = null

  constructor: () ->

  add: (data) ->
    items = data

  all: () ->
    items

  at: (index) ->
    items[index]

  get: (name, value) ->
    query = {}
    query[name] = value

    _.find items, query # see [_.find()](http://lodash.com/docs#find) docs

window.Model = Model