Facture.InvoiceEditController = Ember.ObjectController.extend
  actions:
    save: ->
      @get('model').save().then((=>
        # Reload all line items for the invoice as they may have a new ID
        @get('model.lineItems').then (a) -> a.reloadLinks()

        @transitionToRoute 'project', @get('model.project')
      ), (=>))

    cancel: ->
      # Rollback the invoice and reload its line items
      @get('model').rollback()
      @get('model.lineItems').then (a) -> a.reloadLinks()

      @transitionToRoute 'project', @get('model.project')

    newLineItem: ->
      @get('lineItems').addObject(@store.createRecord('lineItem', { price: 23, quantity: 1 }))

    deleteLineItem: (lineItem) ->
      # Manually set dirty as Invoice#isThisOrLineItemsDirty won't know about deletions
      @get('model').send('becomeDirty')
      @get('lineItems').removeObject(lineItem)
