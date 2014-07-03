module 'New invoice specs', {
  setup: ->
    Facture.Project.FIXTURES = [
      id: 1,
      name: 'Acme Project 1',
      code: 'AP1'
    ]
  teardown: ->
    Facture.reset()
}

test 'Creating a new invoice', ->
  visit "/projects/1/invoices/new"

  andThen ->
    ok($("button:contains('Save')").length != 0, "Save button exists")