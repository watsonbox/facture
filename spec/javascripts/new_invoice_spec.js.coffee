module 'New invoice specs', {
  setup: ->
    Facture.Project.FIXTURES = [
      { id: 1, name: 'Acme Project 1', code: 'AP1' },
      { id: 2, name: 'Acme Project 2', code: 'AP2', currency: 'GBP' }
    ]
}

test 'Creating a new invoice', ->
  visit "/projects/1"

  andThen ->
    click('#newInvoice')

  andThen ->
    ok($("button:contains('Save')").length != 0, "Save button not found")
    equal(find('#invoiceReference').val(), 'ITS/AP1001', 'Default reference not set')

  andThen ->
    fillIn('#invoiceReference', 'Reference')
    find('#invoiceCurrency').val('EUR').change()
    fillIn('#invoiceDate', '2014-07-08')

    click('#newLineItem').then ->
      fillIn('table#lineItems input:eq(0)', 'Some work')
      fillIn('table#lineItems input:eq(1)', '22.99')

  andThen ->
    click('#saveButton').then ->
      equal(find('#invoices tbody tr:eq(0) td:eq(0)').text(), 'Reference', 'New invoice reference not found')
      equal(find('#invoices tbody tr:eq(0) td:eq(1)').text(), 'July 8 2014', 'New invoice date not found')
      equal(find('#invoices tbody tr:eq(0) td:eq(3)').text(), 'Awaiting Payment', 'New invoice has incorrect status')

  andThen ->
    visit("/projects/1/invoices/new").then ->
      equal(find('#invoiceReference').val(), 'ITS/AP1002', 'Default reference not set')


test 'Creating a new invoice with default project currency', ->
  visit "/projects/2"

  andThen ->
    click('#newInvoice')

  andThen ->
    equal(find('#invoiceCurrency').val(), 'GBP', 'Default currency not set')