Facture.InvoiceEditController = Ember.ObjectController.extend
  actions:
    save: ->
      @get('model').save()
      @transitionToRoute 'project', @get('model.project')