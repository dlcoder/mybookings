window.Mybookings ||= {}

class Mybookings.UseByResource

  @render: (selector, resourceTypeInputSelector) ->
    return if $(selector).html()

    resourceTypeId = $(resourceTypeInputSelector).val();

    options = {
      distributeSeries: true,
      plugins: [
        ctBarLabels({
          labelClass: 'ct-bar-label',
          textAnchor: 'middle'
        })
      ]
    }

    $.getJSON("/backend/resource_types/#{resourceTypeId}/use_by_resource.json")
      .done((dataset) ->
        new Chartist.Bar(selector, dataset, options))

    $(resourceTypeInputSelector).on 'change', ->
      resourceTypeId = $(this).val()
      $.getJSON("/backend/resource_types/#{resourceTypeId}/use_by_resource.json")
        .done((dataset) ->
          $(selector).get(0).__chartist__.update(dataset))
