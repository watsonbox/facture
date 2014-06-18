# For more information see: http://emberjs.com/guides/routing/

Facture.Router.map ->
  @resource 'project', path: '/projects/:project_id', ->
    @resource 'invoices', path: '/invoices', ->
      @route 'new'

  @resource 'invoices', path: '/invoices', ->
    @resource 'invoice', path: '/:invoice_id', ->
      @route 'edit'

  @resource 'lineItem', path: '/line_items/:line_item_id'