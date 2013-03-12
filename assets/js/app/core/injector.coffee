class Injector

  constructor: () ->
    @modules = {}

  register: (name, klass) ->
    if @modules[name]
      throw Error "The module '#{name}' already exists in Injector"

    else
      @modules[name] = klass

  getModule: (name) ->
    module = @modules[name]

    if !module
      throw Error "The module '#{name}' already exists in Injector"

    module

  getDeps: (depsArray) ->
    deps = []

    for name in depsArray
      dep = @modules[name]

      if !dep
        throw Error "The dependancy '#{name}' doesn't exist in Injector"

      deps.push dep

    deps

  process: (name, target) ->
    depsArray = target['inject'] ? []

    @processModule name, target, @getDeps depsArray

  processModule: (name, klass, args) ->
    C = () ->
      klass.apply @, args

    C.prototype = klass.prototype
    C.prototype.toString = () ->
      name

    new C()

try
  module.exports = Injector
catch e
  window.injector = do () ->
    new Injector()