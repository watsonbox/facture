Facture.Project = DS.Model.extend
  name: DS.attr('string')
  code: DS.attr('string')
  redmineProjectId: DS.attr('number')
  partial: DS.attr('boolean')
  invoices: DS.hasMany('invoice', { async: true })