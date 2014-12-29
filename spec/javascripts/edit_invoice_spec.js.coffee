module 'Edit invoice specs', {
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

test 'Editing an existing invoice and cancelling', ->
  visit "/projects/1"

  andThen ->
    # Click on edit invoice button
    click("#invoices tbody tr:eq(0) button:eq(0)").then ->
      equal(find('.navbar-text').text(), 'Acme Project 1: Invoice SERV/AP1/001', 'Editing invoice failed')

  andThen ->
    click("#cancelButton")
    equal(find('.navbar-text').text(), 'Acme Project 1', 'Cancelling invoice edit failed')