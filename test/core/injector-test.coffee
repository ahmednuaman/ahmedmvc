assert = require('chai').assert
Injector = require '../../assets/js/app/core/injector'
injector = new Injector()
App = require '../../assets/js/app/app'
app = new App injector

describe 'App.injector', () ->
  describe 'module', () ->
    response = 1

    it 'should allow me to register a module as a dependancy', () ->
      class Dependancy

        constructor: () ->

        aMethod: () ->
          response

      assert.ok app.module 'Dependancy', Dependancy

    it 'should allow me to register a module as a dependant', () ->
      class Dependant

        constructor: (@dependancy) ->

        aMethod: () ->
          @dependancy.aMethod()

      Dependant.inject = ['Dependancy']

      dependant = app.module 'Dependant', Dependant
      assert.ok dependant

    it 'should let a dependant run a dependancy function just swell', () ->
      dependant = app.injector.getModule 'Dependant'

      assert.ok dependant
      assert.equal dependant.aMethod(), response