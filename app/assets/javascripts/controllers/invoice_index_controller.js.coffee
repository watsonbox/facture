Facture.InvoiceIndexController = Ember.ObjectController.extend
  actions:
    edit: ->
      @transitionToRoute 'invoice.edit', @get('model')