Facture.Invoice = DS.Model.extend
  reference: DS.attr('string')
  date: DS.attr('date')
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