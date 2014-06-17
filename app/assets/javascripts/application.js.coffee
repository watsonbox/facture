#= require moment
#= require jquery
#= require jquery_ujs
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