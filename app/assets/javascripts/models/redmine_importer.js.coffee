# TODO: Handle variable hourly rates
# TODO: Add tracker and feature ID
class Facture.RedmineImporter
  constructor: (@store, @redmineUrl, @redmineApiKey) ->

  # Creates line items for all uninvoiced time entries associated with a project
  uninvoicedTimeForProject: (project_id, callback) ->
    timeEntryActivityPrices = []

    @timeEntryActivityPrices(project_id)
    .then (activityPrices) =>
      timeEntryActivityPrices = activityPrices
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
            price: timeEntryActivityPrices[timeEntry.activity.id],
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

  # Get time entry activity enumeration by Price custom field
  # This functionality depends on the redmine_facture plugin
  # TODO: Submit required redmine changes to the SVN repo
  timeEntryActivityPrices: (project_id) ->
    deferred = $.Deferred()

    $.ajax
      type: "GET"
      url: "#{@redmineUrl}/enumerations/time_entry_activities.json?project_id=#{project_id}"
      dataType: 'jsonp'
      crossDomain: true
      headers: { "Authorization": btoa("#{@redmineApiKey}:") }
      success: (data) =>
        activityPrices = []

        for time_entry_activity in data.time_entry_activities
          if time_entry_activity.custom_fields
            for custom_field in time_entry_activity.custom_fields
              if custom_field.name == 'Price' && custom_field.value
                activityPrices[time_entry_activity.id] = custom_field.value

        deferred.resolve activityPrices

    deferred.promise()