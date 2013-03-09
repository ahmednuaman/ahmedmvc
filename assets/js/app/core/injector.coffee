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
      throw
        name: 'ModuleExistsError'
        message: "The module '#{name}' already exists in Injector"

    else
      # create a ref
      @modules[name] = klass

  getDeps: (depsArray) ->
    # go through the `depsArray` and pick out the modules and then return an
    # array of module references
    deps = []

    for name in depsArray
      # check that the module is actually registered with our injector
      dep = @modules[name]

      if !dep?
        # uh oh
        throw
          name: 'ModuleNotFoundError'
          message: "The module '#{name}' doesn't exist in Injector"

      # otherwise add it to our deps array
      deps.push dep

    # return the deps
    deps

  inject: (target) ->
    # take our target and inject our dependancies into it, this runs our target
    # and returns a reference to the target's instance
    # we take the deps from arguments{1,}, so we take the arguments, convert it
    # to an array and get the entries after the first
    depsArray = Array.prototype.slice.apply arguments, 1

    # now we apply the deps on to our target
    target.apply target, @getDeps depsArray