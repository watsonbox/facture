Facture.InvoicesNewRoute = Ember.Route.extend
  model: ->
    # Seems we must ensure the invoices exist or the invoice is not properly associated
    project = @modelFor('project')
    project.get('invoices').then -> project.newInvoice()

  renderTemplate: ->
    @render('invoice.edit', {
      controller: 'invoicesNew',
      into: 'application'
    })

  setupController: (controller, model) ->
    @controllerFor('navbar').set('title', @modelFor('project').get('name'))
    controller.set('content', model)