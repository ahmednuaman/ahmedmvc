# this file won't be included in the optimised version of the app, instead we'll
# use the loading order stored here to compile our app
basePath = 'assets/js/app/'
fileExt = '.js?x=' + (new Date()).getTime() # cache busting
filesToLoad = [
  '../vendor/jquery/jquery' # really we should swap this with a custom build
  '../vendor/when/when'
  'core/injector'
  'app'
  'controller/loader-partial-controller'
  'controller/menu-partial-controller'
]
head = null

# create our script loader function, we're gonna use `callback` for now as we've
# not loaded our `deferred` library (f' tha po-lice)
loadScript = (src, callback) ->
  script = document.createElement 'script'
  script.src = basePath + src + fileExt
  script.onload = script.onreadystatechange = () ->
    # check this badboy has loaded
    if !@.readyState or @.readyState is 'loaded' or @.readyState is 'complete'
      # prevent any memory leaks by removing the script and any handlers
      script.onload = script.onreadystatechange = null
      head.removeChild script
      script = null

      # fire our callback
      callback()

  # add the script to the head and watch out for **magic**
  head.appendChild script

# now we create our iterator function that checks if there are more scripts to
# be loaded
loadScripts = () ->
  # check that we _actually_ have scripts to load
  if filesToLoad.length
    # get the first/beginning script to load
    script = filesToLoad.shift()

    # run `loadScript` and pass self as a callback
    loadScript script, loadScripts

try
  # expose `filesToLoad` to node so that we can haz use it to build our app
  module.exports =
    filesToLoad: filesToLoad
catch e
  # finally expose a function to the `window` where we can start all this bizniz
  # off of (that's right)
  window.bootstrap = () ->
    # this is where the magic happens, first we keep a ref to our DOM's head
    # as that's where we're gonna stick our scripts
    head = document.getElementsByTagName('head')[0]

    # load our scripts!
    loadScripts()