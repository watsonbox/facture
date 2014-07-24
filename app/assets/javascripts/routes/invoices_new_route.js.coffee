Facture.InvoicesNewRoute = Ember.Route.extend
  model: ->
    @modelFor('project').newInvoice()

  renderTemplate: ->
    @render('invoice.edit', {
      controller: 'invoicesNew',
      into: 'application'
    })

  setupController: (controller, model) ->
    @controllerFor('navbar').set('title', @modelFor('project').get('name'))
    controller.set('content', model)