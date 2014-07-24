Facture.Project = DS.Model.extend
  name: DS.attr('string')
  code: DS.attr('string')
  redmineProjectId: DS.attr('number')
  currency: DS.attr('string')
  partial: DS.attr('boolean')
  invoices: DS.hasMany('invoice', { async: true })

  newInvoice: ->
    @store.createRecord('invoice', { project: this, currency: @get('currency') })