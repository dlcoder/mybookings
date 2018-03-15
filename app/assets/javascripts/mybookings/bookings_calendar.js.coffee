window.Mybookings ||= {}

class Mybookings.BookingsCalendar
  @render: (selector, eventsUrl, locale='en') ->
    return if $(selector).data('fullcalendar-loaded')
    $(selector).data('fullcalendar-loaded', true)

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

    $(document).one 'turbolinks:click', ->
      $(selector).data('fullcalendar-loaded', false)
      $(selector).fullCalendar('destroy')

    return
