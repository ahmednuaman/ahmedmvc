# part of ahmedmvc's core; we use it to inject registered modules into, well
# anything really
class Injector

  constructor: () ->
    # set up a blank object to hold our injected modules
    @modules = {}

  register: (name, klass) ->
    # so here we simply hold a reference to the class we can haz registered and
    # able to be injected, first check that we're not registering something that
    # already goes by this name
    if @modules[name]?
      # throw an error yo
      throw Error "The module '#{name}' already exists in Injector"

    else
      # create a ref
      @modules[name] = klass

  getModule: (name) ->
    # aims to return a single init'd module
    module = @modules[name]

    if !module?
      # throw an error yo
      throw Error "The module '#{name}' already exists in Injector"

    module

  getDeps: (depsArray) ->
    # go through the `depsArray` and pick out the modules and then return an
    # array of module references
    deps = []

    for name in depsArray
      # check that the module is actually registered with our injector
      dep = @modules[name]

      if !dep?
        # uh oh
        throw Error "The dependancy '#{name}' doesn't exist in Injector"

      # otherwise add it to our deps array
      deps.push dep

    # return the deps
    deps

  process: (name, target) ->
    # take our target and inject our dependancies into it, this runs our target
    # and returns a reference to the target's instance
    # we take the deps from arguments{1,}, so we take the arguments, convert it
    # to an array and get the entries after the first
    depsArray = target['inject'] ? []

    # now we apply the deps on to our target depending on the target's type
    switch target.type
      when 'controller'
        return @processController name, target, @getDeps depsArray

  processController: (name, klass, args) ->
    # a generic solution to do `new Class([args])`, first set up a temp func
    Controller = () ->
      klass.apply @, args

    # reapply the prototype so that it's the klass's
    Controller.prototype = klass.prototype
    Controller.prototype.toString = () ->
      name

    # start it all up
    new Controller()

try
  # for testing
  module.exports = Injector
catch e
  # make our injector available globally
  window.injector = () ->
    new Injector()