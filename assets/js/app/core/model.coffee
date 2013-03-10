# our base `Model` class, it acts as a collection
class Model
  # keep a reference to this model's data
  @data: null

  constructor: () ->

  add: (data) ->
    @data = data

  all: () ->
    # throw an error if data is null
    if !@data?
      throw Error 'This model contains no data'

    @data

  at: (index) ->
    item = @data[index]

    # throw an error if the index is out of scope
    if !item?
      throw Error "Supplied index #{index} is out of scope"

    item

  get: (name, value) ->
    query = {}
    query[name] = value

    # see [_.find()](http://lodash.com/docs#find) docs
    item = _.find @data, query

    # throw an error if the index is out of scope
    if !item?
      throw Error "Supplied name, value: #{name}, #{value} was not found"

    item

try
  # for testing
  _ = require 'lodash'

  module.exports = Model
catch e
  # for app
  window.Model = Model