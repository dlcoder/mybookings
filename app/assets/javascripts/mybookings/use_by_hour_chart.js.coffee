class Mybookings.UseByHourChart extends Mybookings.Chart

  drawChar: (dataset) =>
    options = {
      chartPadding: {
        top: 60
      },
      plugins: [
        ctLineLabels({
          textAnchor: 'middle'
        })
      ]
    }

    new Chartist.Line(@selector, dataset, options)
    super

  getUrl: ->
    resourceTypeId = $(@resourceTypeInputSelector).val()
    return Routes.mybookings_use_by_hour_backend_resource_type_path({id: resourceTypeId})
