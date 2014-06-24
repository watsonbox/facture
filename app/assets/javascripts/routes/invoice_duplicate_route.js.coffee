Facture.InvoiceDuplicateRoute = Ember.Route.extend
  model: ->
    invoice = @store.createRecord('invoice', @existingInvoiceJSON())
    @eachExistingLineItemJSON (lineItem) =>
      invoice.get('lineItems').addObject(@store.createRecord('lineItem', lineItem))
    invoice

  renderTemplate: ->
    @render('invoice.edit', {
      controller: 'invoicesNew',
      into: 'application'
    })

  setupController: (controller, model) ->
    @controllerFor('navbar').set('title', @modelFor('invoice').get('project').get('name'))
    @controllerFor('invoices.new').set('content', model)

  # Get existing invoice as JSON with correct project association
  existingInvoiceJSON: ->
    invoiceJSON = @modelFor('invoice').toJSON()
    invoiceJSON.project = @modelFor('invoice').get('project')
    invoiceJSON

  # Get each existing lineItem as JSON without invoice association
  eachExistingLineItemJSON: (f) ->
    @modelFor('invoice').get('lineItems').then =>
      @modelFor('invoice').get('lineItems').forEach (lineItem) =>
        lineItemJSON = lineItem.toJSON()
        delete lineItemJSON.invoice
        f lineItemJSON