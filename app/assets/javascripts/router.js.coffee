# For more information see: http://emberjs.com/guides/routing/

Facture.Router.map ->
  @resource 'project', path: '/projects/:project_id'
  @resource 'invoice', path: '/invoices/:invoice_id', ->
    @route 'edit'