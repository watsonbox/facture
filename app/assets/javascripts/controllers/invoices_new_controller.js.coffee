Facture.InvoicesNewController = Ember.ObjectController.extend
  actions:
    save: ->
      @get('model').save().then((=>
        @get('project').get('invoices').then (invoices) =>
          invoices.addObject @get('model')
        @transitionToRoute 'project', @get('project')
      ), (=>))

    cancel: ->
      project = @get('project')
      @get('model').deleteRecord()
      @transitionToRoute 'project', project

    newLineItem: ->
      @get('lineItems').addObject(@store.createRecord('lineItem', { price: 0, quantity: 1 }))

    deleteLineItem: (lineItem) ->
      @get('lineItems').removeObject(lineItem)
