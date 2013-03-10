_ = require 'lodash'
assert = require('chai').assert
Model = require '../../assets/js/app/core/model'
model = new Model()

describe 'Model', () ->
  data = [
    {
      foo: 'bar1'
    },
    {
      foo: 'bar2'
    },
    {
      foo: 'bar3'
    }
  ]

  describe 'add', () ->
    it 'should allow me to add some data', () ->
      assert.ok model.add data

  describe 'all', () ->
    it 'should return all the data', () ->
      all = model.all()

      assert.equal all.length, data.length
      assert.equal all, data

    it 'should throw an error if the model contains no data', () ->
      all = () ->
        fakeModel = new Model()

        fakeModel.all()

      assert.throws all, Error

  describe 'at', () ->
    it 'should return an entry of data at an index', () ->
      at = model.at 1

      assert.equal at, data[1]

    it 'should throw an error if the index is out of scope', () ->
      at = () ->
        model.at 1000

      assert.throws at, Error

  describe 'get', () ->
    it 'should return an entry of data by name', () ->
      get = model.get 'foo', 'bar2'

      assert.equal get, data[1]

    it 'should throw an error if the name, value is not found', () ->
      get = () ->
        model.get 'foo', 'bar100'

      assert.throws get, Error