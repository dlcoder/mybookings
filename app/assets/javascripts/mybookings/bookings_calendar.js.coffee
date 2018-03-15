class Mybookings.BookingsCalendar
  @render: (selector, eventsUrl, locale='en') ->
    # TODO: review that dirty hack to deal with turbolinks
    return if $(selector).html()

    options =
      allDaySlot: false
      defaultView: 'listWeek'
      editable: false
      eventSources: [{ url: eventsUrl }]
      header: { left: 'prev,next today', center: 'title', right: 'month,agendaWeek,agendaDay,listWeek' }
      height: 550
      locale: locale
      slotMinutes: 30
      timeFormat: 'H(:mm)'

    $(selector).fullCalendar(options)
    return
