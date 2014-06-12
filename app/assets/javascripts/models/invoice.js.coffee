Facture.Invoice = DS.Model.extend
  reference: DS.attr('string')
  date: DS.attr('date')
  project: DS.belongsTo('project')