class EachDirective

  constructor: () ->

  directive: (array, options) ->
    out = ''

    for item in array
      item.index = _i
      item.nth = _i + 1
      item.previous = (array.slice _i - 1)[0]
      item.next = if _i <= _len then array[_i] else array[0]

      out += options.fn item

    new Handlebars.SafeString out

try
  module.exports = EachDirective
catch e
  Handlebars.registerHelper 'each', (new EachDirective()).directive