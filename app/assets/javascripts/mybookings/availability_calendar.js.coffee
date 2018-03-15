class Mybookings.AvailabilityCalendar
  @render: (selector, resourceInputSelector, startDateInputSelector, endDateInputSelector, locale = "en") ->
    # TODO: review that dirty hack to deal with turbolinks
    return if $(selector).html()

    resourceId = $(resourceInputSelector).val();
    options =
      locale: locale
      editable: false
      defaultView: 'agendaWeek'
      allDaySlot: false
      height: 500
      slotMinutes: 30
      eventSources: [
        {
          url: Routes.mybookings_resource_events_path({resource_id: resourceId})
        }
      ]
      selectable: true
      selectHelper: true
      select: (start, end) ->
        $(startDateInputSelector).val(start.format('DD-MM-YYYY HH:mm'))
        $(endDateInputSelector).val(end.format('DD-MM-YYYY HH:mm'))

    $(selector).fullCalendar(options)

    $(resourceInputSelector).on 'change', ->
      resourceId = $(this).val()
      events =
        url: Routes.mybookings_resource_events_path({resource_id: resourceId})

      $(selector).fullCalendar('removeEvents')
      $(selector).fullCalendar('removeEventSource', events)
      $(selector).fullCalendar('addEventSource', events)
