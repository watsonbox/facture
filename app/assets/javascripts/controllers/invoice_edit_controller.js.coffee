Facture.InvoiceEditController = Ember.ObjectController.extend
  actions:
    save: ->
      @get('model').save().then((=>

        # Refresh the invoice including all the line items (which may have new IDs)
        # Based on code from: https://github.com/emberjs/data/issues/1913
        # As mentioned in issue, would be nice to know why link relationships are not reloaded
        model = @get('model')
        model.propertyWillChange('data')
        data = model._data
        model.eachRelationship (key, relationship) ->
          if data.links && data.links[key]
            if model && relationship.options.async
              model._relationships[key] = null
        model.propertyDidChange('data')

        @transitionToRoute 'project', @get('model.project')
      ), (=>))

    newLineItem: ->
      @get('lineItems').addObject(@store.createRecord('lineItem', { price: 23, quantity: 1 }))

    deleteLineItem: (lineItem) ->
      @get('lineItems').removeObject(lineItem)
