# set up our app core
class App
  constructor: () ->
    console.log 'App'
    alert 'App'

# this function kicks off our app
window.app = () ->
  new App()