Facture.Project = DS.Model.extend
  name: DS.attr('string')
  code: DS.attr('string')
  invoices: DS.hasMany('invoice')