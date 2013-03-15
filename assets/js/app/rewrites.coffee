window.whenjs = window.when

if !Array.prototype['lastIndex']
  Array.prototype.__defineGetter__ 'lastIndex', () ->
    this.length - 1