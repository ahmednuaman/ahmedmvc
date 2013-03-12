basePath = 'assets/js/app/'
fileExt = '.js'
filesToLoad = [
  '../vendor/handlebars/handlebars'
  '../vendor/jquery/jquery'
  '../vendor/lodash/lodash'
  '../vendor/when/when'
  'rewrites'
  'core/injector'
  'core/controller'
  'core/model'
  'core/view'
  'core/partial-view'
  'app'
  'state-manager'
  'model/menu-model'
  'service/menu-service'
  'view/loader-view'
  'view/menu-view'
  'view/home-partial-view'
  'view/section-partial-view'
  'view/subsection-partial-view'
  'view/main-view'
  'controller/menu-controller'
  'controller/home-partial-controller'
  'controller/section-partial-controller'
  'controller/subsection-partial-controller'
  'controller/main-controller'
]
head = null

loadScript = (src, callback) ->
  script = document.createElement 'script'
  script.src = basePath + src + fileExt
  script.onload = script.onreadystatechange = () ->
    if !@.readyState or @.readyState is 'loaded' or @.readyState is 'complete'
      script.onload = script.onreadystatechange = null
      head.removeChild script
      script = null

      callback()

  head.appendChild script

loadScripts = () ->
  if filesToLoad.length
    script = filesToLoad.shift()

    loadScript script, loadScripts

try
  module.exports =
    filesToLoad: filesToLoad
catch e
  do () ->
    head = document.getElementsByTagName('head')[0]

    loadScripts()