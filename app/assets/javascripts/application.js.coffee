#= require moment
#= require accountingjs
#= require jquery
#= require jquery_ujs
#= require bootstrap-datepicker
#= require bootstrap.min
#= require jquery.flot.min
#= require jquery.flot.time.min
#= require handlebars
#= require ember
#= require ember-data
#= require_self
#= require facture

# for more details see: http://emberjs.com/guides/application/
window.Facture = Ember.Application.create
  app_title: 'Facture'

# Allow errors on arbitrary properties, not just defined attributes or relationships
# https://github.com/emberjs/data/pull/1984 - can remove when this is merged
DS.Model.reopen
  adapterDidInvalidate: (errors) ->
      recordErrors = this.get('errors')
      for key of errors
        continue if (!errors.hasOwnProperty(key))
        recordErrors.add(key, errors[key])

# Automatically bind data attributes in ember view helpers
Ember.View.reopen
  init: ->
    @_super()
    Em.keys(this).forEach (key) =>
      if key.substr(0, 5) == 'data-'
        @get('attributeBindings').pushObject key

$ -> $('body').tooltip
  selector: "button[data-toggle=tooltip],a[data-toggle=tooltip]"

RegExp.escape = (s) -> s.replace(/[-\/\\^$*+?.()|[\]{}]/g, '\\$&')