module 'Show project specs', {
  setup: ->
    Facture.Project.FIXTURES = [
      { id: 1, name: 'Acme Project 1', code: 'AP1' },
      { id: 2, name: 'Acme Project 2', code: 'AP2', currency: 'GBP' }
    ]
}

test 'Viewing project two preserves menu order', ->
  visit "/projects/2"

  andThen ->
    equal(find('.navbar-nav .dropdown-menu li:eq(0) a').text(), 'Acme Project 1', 'Incorrect project menu order')