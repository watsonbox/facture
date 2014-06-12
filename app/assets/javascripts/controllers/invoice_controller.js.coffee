Facture.InvoiceController = Ember.ObjectController.extend
  actions:
    edit: ->
      @transitionToRoute 'invoice.edit', @get('model')