Facture.InvoiceEditRoute = Ember.Route.extend
  model: -> @modelFor 'invoice'

  setupController: (controller, model) ->
    @controllerFor('navbar').set('title', "#{model.get('project.name')}: Invoice #{model.get('reference')}")
    controller.set('content', model)