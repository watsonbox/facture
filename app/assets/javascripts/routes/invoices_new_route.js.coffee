Facture.InvoicesNewRoute = Ember.Route.extend
  model: ->
    @store.createRecord('invoice')

  # Re-use the edit template for now
  renderTemplate: ->
    @render('invoice.edit', {
      controller: 'invoicesNew',
      into: 'application'
    })