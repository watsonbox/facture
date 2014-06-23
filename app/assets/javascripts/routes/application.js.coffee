Facture.ApplicationRoute = Ember.Route.extend
  setupController: (controller) ->
    controller.set 'projects', @store.find('project')

  actions:
    willTransition: ->
      # Clear title after every transition (must allow events to bubble if overridden elsewhere)
      @controllerFor('navbar').set('title', null)