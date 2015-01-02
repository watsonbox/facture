Facture.DatePickerView = Ember.TextField.extend
  didInsertElement: ->
    $(@get('element')).datepicker(
      format: "yyyy-mm-dd"
      autoclose: true,
      useCurrent: true
    )

    if $(@get('element')).val() == ''
      $(@get('element')).datepicker('setDate', new Date())

    @_super()