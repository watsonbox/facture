module 'Duplicate invoice specs', {
  setup: ->
    Facture.Project.FIXTURES = [
      id: 1,
      name: 'Acme Project 1',
      code: 'AP1',
      invoices: [1]
    ]

    Facture.Invoice.FIXTURES = [
      id: 1,
      reference: 'SERV/AP1/001',
      currency: 'EUR',
      date: '2014-07-07',
      paid: true,
      project: 1
    ]
}

test 'Duplicating an invoice', ->
  visit "/projects/1"

  # Check that the original invoice is marked paid
  andThen ->
    click("#invoices tbody tr:eq(0) a:eq(0)").then ->
      equal(find(".navbar-text").text(), "Acme Project 1: Invoice SERV/AP1/001")
      ok($("#paidButton.active").length, "Invoice was not marked as paid")

  # Duplicate the invoice
  andThen ->
    visit("/projects/1").then ->
      click("#invoices tbody tr:eq(0) a.duplicateInvoice").then ->
        fillIn("#invoiceReference", "Duplicate")
        click('#saveButton')

  # Check that the duplicated invoice is marked unpaid
  andThen ->
    visit("/projects/1").then ->
      equal(find('#invoices tbody tr:eq(1) td:eq(0)').text(), 'Duplicate', 'Duplicate invoice reference not found')
      equal(find('#invoices tbody tr:eq(1) td:eq(3)').text(), 'Awaiting Payment', 'Duplicate invoice has incorrect status')