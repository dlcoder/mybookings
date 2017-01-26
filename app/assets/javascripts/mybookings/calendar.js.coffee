class @Calendar

  constructor: (idCalendar, idSelect, locale = "en") ->

    firstResourceId = $(idSelect).val();

    $(idCalendar).fullCalendar
      locale: locale
      editable: false,
      minTime: "08:00:00",
      maxTime: "23:00:00",
      defaultView: 'agendaWeek',
      allDaySlot: false,
      height: 700,
      slotMinutes: 30,
      eventSources: [
        {
          url: "/resources/#{firstResourceId}/events.json"
        },
      ],

    $(idSelect).on 'change', ->
      resourceId = $(this).val() ;
      events =
        url: "/resources/#{resourceId}/events.json"

      $(idCalendar).fullCalendar( 'removeEventSource', events);
      $(idCalendar).fullCalendar( 'addEventSource', events);


