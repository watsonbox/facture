Facture.InvoiceSerializer = DS.ActiveModelSerializer.extend(DS.EmbeddedRecordsMixin, {
  attrs: {
    lineItems: { embedded: 'always' }
  }
})