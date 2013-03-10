assert = require('chai').assert
bootstrap = require '../assets/js/app/bootstrap'

describe 'bootstrap.filesToLoad', () ->
  it 'should return an array of files', () ->
    assert.ok Array.isArray bootstrap.filesToLoad
    assert.ok bootstrap.filesToLoad.length > 0