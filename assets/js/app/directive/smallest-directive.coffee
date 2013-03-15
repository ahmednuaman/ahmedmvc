class SmallestDirective

  constructor: () ->

  directive: (test1, test2, options) ->
    if test1 > test2
      out = test2

    else
      out = test1

    out

try
  module.exports = SmallestDirective
catch e
  Handlebars.registerHelper 'smallest', (new SmallestDirective()).directive