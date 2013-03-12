class Model

  constructor: (@data=null) ->

  add: (data) ->
    @data = data

  all: () ->
    if !@data?
      throw Error 'This model contains no data'

    @data

  at: (index) ->
    item = @data[index]

    if !item?
      throw Error "Supplied index #{index} is out of scope"

    item

  get: (name, value) ->
    query = {}
    query[name] = value
    item = _.find @data, query

    if !item?
      throw Error "Supplied name, value: #{name}, #{value} was not found"

    item

try
  _ = require 'lodash'
  module.exports = Model
catch e
  window.Model = Model