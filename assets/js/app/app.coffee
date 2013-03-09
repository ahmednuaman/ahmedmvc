# set up our app core
class App
  constructor: () ->
    body = document.getElementsByTagName('body')[0]

    h1 = document.createElement 'h1'
    h1.innerHTML = 'Awwww sheeeet'

    body.appendChild h1

# this function kicks off our app
window.app = () ->
  new App()