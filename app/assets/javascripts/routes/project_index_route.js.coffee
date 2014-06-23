Facture.ProjectIndexRoute = Ember.Route.extend
  setupController: (controller, model) ->
    @controllerFor('navbar').set('title', @modelFor('project').get('name'))
    controller.set('content', model)