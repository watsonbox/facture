Facture.InvoicesNewController = Ember.ObjectController.extend
  needs: ['project']

  actions:
    save: ->
      project = @get('controllers.project').get('model')

      @get('model').set('project', project)
      @get('model').save().then((=>
        project.get('invoices').then (invoices) =>
          invoices.addObject @get('model')
        @transitionToRoute 'project', @get('model.project')
      ), (=>))

    cancel: ->
      @get('model').deleteRecord()
      @transitionToRoute 'project', @get('controllers.project').get('model')

    newLineItem: ->
      @get('lineItems').addObject(@store.createRecord('lineItem', { price: 23, quantity: 1 }))

    deleteLineItem: (lineItem) ->
      @get('lineItems').removeObject(lineItem)
