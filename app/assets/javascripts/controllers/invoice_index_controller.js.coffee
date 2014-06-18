Facture.InvoiceIndexController = Ember.ObjectController.extend
  actions:
    edit: ->
      @transitionToRoute 'invoice.edit', @get('model')

    delete: ->
      if confirm("Are you sure you want to delete invoice #{@get('model.reference')}?")
        project = @get('model.project')
        @get('model').destroyRecord().then =>
          project.get('invoices').removeObject(@get('model'))