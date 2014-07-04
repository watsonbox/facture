Facture.Invoice = DS.Model.extend
  reference: DS.attr('string')
  date: DS.attr('string')
  currency: DS.attr('string')
  paid: DS.attr('boolean')
  defaultCurrencyExchangeRate: DS.attr('number')
  subtotal: DS.attr('number')
  project: DS.belongsTo('project')
  lineItems: DS.hasMany('lineItem', { async: true })

  lineItemAmounts: Ember.computed.mapBy('lineItems', 'amount')
  lineItemAmountsSum: Ember.computed.sum('lineItemAmounts')

  # Uses subtotal roll-up data until async lineItems become available
  amount: (->
    if @cacheFor('lineItems')
      @get('lineItemAmountsSum')
    else
      @get('subtotal')
  ).property('lineItems.@each.amount')

  # Amount converted to default currency
  amountInDefaultCurrency: (->
    if Facture.config.default_currency && Facture.config.default_currency != @get('currency') && @get('defaultCurrencyExchangeRate')
      @get('defaultCurrencyExchangeRate') * @get('amount')
    else if Facture.config.default_currency == @get('currency')
      @get('amount')
  ).property('amount', 'defaultCurrencyExchangeRate')

  # Invoice is dirty if it or any line items are dirty
  # (deleting a line item manually sets the dirty state on the invoice)
  # Note: hasMany dirty tracking doesn't appear to be available in ember-data yet
  isThisOrLineItemsDirty: (->
    @get('isDirty') || (@cacheFor('lineItems') && !@get('lineItems').every (li) -> !li.get('isDirty'))
  ).property('isDirty','lineItems.@each.isDirty')

  # Duplicate this invoice and its line items
  duplicate: ->
    invoice = @store.createRecord('invoice', @existingInvoiceJSON())
    invoice.set('paid', false)
    @eachExistingLineItemJSON (lineItem) =>
      invoice.get('lineItems').then =>
        invoice.get('lineItems').addObject(@store.createRecord('lineItem', lineItem))
    invoice

  # Get existing invoice as JSON with correct project association
  existingInvoiceJSON: ->
    invoiceJSON = @toJSON()
    invoiceJSON.project = @get('project')
    invoiceJSON

  # Get each existing lineItem as JSON without invoice association
  eachExistingLineItemJSON: (f) ->
    @get('lineItems').then =>
      @get('lineItems').forEach (lineItem) =>
        lineItemJSON = lineItem.toJSON()
        delete lineItemJSON.invoice
        f lineItemJSON