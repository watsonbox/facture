Facture.Invoice = DS.Model.extend
  reference: DS.attr('string')
  project: DS.belongsTo('project')