Facture.InvoiceDuplicateRoute = Ember.Route.extend
  model: ->
    @modelFor('invoice').duplicate()

  renderTemplate: ->
    @render('invoice.edit', {
      controller: 'invoicesNew',
      into: 'application'
    })

  setupController: (controller, model) ->
    @controllerFor('navbar').set('title', @modelFor('invoice').get('project').get('name'))
    @controllerFor('invoices.new').set('content', model)