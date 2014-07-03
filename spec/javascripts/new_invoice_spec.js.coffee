module 'New invoice specs', {
  setup: ->
    Facture.reset()
}

test 'Creating a new invoice', ->
  visit "/"
  expect 0 # Don't expect anything