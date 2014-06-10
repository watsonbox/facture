Facture.ApplicationRoute = Ember.Route.extend
  setupController: (controller) ->
    controller.set('projects', @store.find('project'))