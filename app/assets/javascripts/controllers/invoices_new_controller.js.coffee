Facture.InvoicesNewController = Ember.ObjectController.extend
  isImporting: false

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

    importRedmineTimeEntries: ->
      @set('isImporting', true)

      importer = new Facture.RedmineImporter @store, Facture.config.redmine_url, Facture.config.redmine_api_key
      importer.uninvoicedTimeForProject @get('project.redmineProjectId'), (lineItems) =>
        for lineItem in lineItems
          @get('lineItems').addObject lineItem

        @set('isImporting', false)
