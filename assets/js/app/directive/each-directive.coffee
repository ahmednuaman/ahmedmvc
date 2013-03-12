class EachDirective

  constructor: () ->

  directive: (array, options) ->
    out = ''

    array.reverse()

    for item in array
      item.index = _i

      out += options.fn item

    new Handlebars.SafeString out

try
  module.exports = EachDirective
catch e
  Handlebars.registerHelper 'each', (new EachDirective()).directive