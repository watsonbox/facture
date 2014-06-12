Ember.Handlebars.registerBoundHelper 'prettyDate', (date) ->
  moment(date).format('LL')