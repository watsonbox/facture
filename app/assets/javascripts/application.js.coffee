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

DS.ManyArray.reopen
  # Refresh hasMany with links
  # Based on code from: http://stackoverflow.com/questions/19983483/how-to-reload-an-async-with-links-hasmany-relationship
  # As mentioned in issue, would be nice to know why link relationships are not reloaded
  reloadLinks: ->
    records = @get('content')
    store = @get('store')
    owner = @get('owner')
    name = @get('name')
    resolver = Ember.RSVP.defer()
    meta = owner.constructor.metaForProperty(name)
    link = owner._data.links[meta.key]
    relationship = Ember.get(owner.constructor, 'relationshipsByName').get(name)

    records = store.findHasMany(owner, link, relationship, resolver)

    # Rollback each record to clear dirty status
    resolver.promise.then (records) ->
      records.forEach (r) -> r.rollback()