Facture.LineItem = DS.Model.extend
  description: DS.attr('string')
  price: DS.attr('number')
  quantity: DS.attr('number')
  invoice: DS.belongsTo('invoice')

  amount: (-> @get('quantity') * @get('price')).property('quantity', 'price')