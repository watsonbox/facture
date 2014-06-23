Facture.DatePicker = Ember.TextField.extend
  didInsertElement: ->
    $(@get('element')).datepicker(
      format: "yyyy-mm-dd"
      autoclose: true
    )

    @_super()