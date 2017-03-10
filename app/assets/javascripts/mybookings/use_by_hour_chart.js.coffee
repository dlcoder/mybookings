window.Mybookings ||= {}

class Mybookings.UseByHour

  @render: (selector, resourceTypeInputSelector) ->
    return if $(selector).html()

    resourceTypeId = $(resourceTypeInputSelector).val();

    options = {
      plugins: [
        ctLineLabels({
          textAnchor: 'middle'
        })
      ]
    }

    $.getJSON("/backend/resource_types/#{resourceTypeId}/use_by_hour.json")
      .done((dataset) ->
        new Chartist.Line(selector, dataset, options))

    $(resourceTypeInputSelector).on 'change', ->
      resourceTypeId = $(this).val()
      $.getJSON("/backend/resource_types/#{resourceTypeId}/use_by_hour.json")
        .done((dataset) ->
          $(selector).get(0).__chartist__.update(dataset))
