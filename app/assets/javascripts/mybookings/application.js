//= require jquery
//= require jquery.turbolinks
//= require jquery_ujs
//= require bootstrap/collapse
//= require moment
//= require fullcalendar
//= require bootstrap-datetimepicker
//= require mybookings/datetimepicker
//= require turbolinks

$(document).ready(function() {

  $('#calendar').fullCalendar({
    editable: false,
    minTime: "08:00:00",
    maxTime: "23:00:00",

    defaultView: 'agendaWeek',
    allDaySlot: false,
    height: 700,
    slotMinutes: 30,
    eventSources: [
      {
        url: '/events.json'
      }
    ],
  })
});
