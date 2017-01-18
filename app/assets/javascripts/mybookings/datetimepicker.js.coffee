$(document).on 'turbolinks:load', ->
  $('input.datetimepicker').datetimepicker({
    format: 'DD-MM-YYYY HH:mm',
  })
