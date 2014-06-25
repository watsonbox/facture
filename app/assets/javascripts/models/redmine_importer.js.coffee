# TODO: Handle variable hourly rates
# TODO: Add tracker and feature ID
class Facture.RedmineImporter
  constructor: (@store, @redmineUrl, @redmineApiKey) ->

  # Creates line items for all uninvoiced time entries associated with a project
  uninvoicedTimeForProject: (project_id, callback) ->
    @invoicedCustomFieldId()
    .then (fieldId) =>
      $.ajax
        type: "GET"
        url: "#{@redmineUrl}/time_entries.json?project_id=#{project_id}&cf_#{fieldId}=0"
        dataType: 'jsonp'
        crossDomain: true
        headers: { "Authorization": btoa("#{@redmineApiKey}:") }
    .done (data) =>
      callback $.map data.time_entries, (timeEntry) =>
        @store.createRecord(
          'lineItem',
          {
            description: "#{timeEntry.spent_on}: #{timeEntry.issue.subject}",
            price: 30,
            quantity: timeEntry.hours
          }
        )

  # Get the ID of the time entry custom field called 'Invoiced'
  invoicedCustomFieldId: ->
    deferred = $.Deferred()

    $.ajax
      type: "GET"
      url: "#{@redmineUrl}/custom_fields.json"
      dataType: 'jsonp'
      crossDomain: true
      headers: { "Authorization": btoa("#{@redmineApiKey}:") }
      success: (data) =>
        for field in data.custom_fields
          if field.name == 'Invoiced'
            deferred.resolve field.id
            return

        throw "No Redmine time entry custom field with name 'Invoiced' was found"

    deferred.promise()