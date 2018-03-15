class Mybookings.UseByResourceChart extends Mybookings.Chart

  drawChar: (dataset) =>
    options = {
      distributeSeries: true,
      chartPadding: {
        top: 60
      },
      plugins: [
        ctBarLabels({
          labelClass: 'ct-bar-label',
          textAnchor: 'middle'
        })
      ]
    }

    new Chartist.Bar(@selector, dataset, options)
    super

  getUrl: ->
    resourceTypeId = $(@resourceTypeInputSelector).val()
    return Routes.mybookings_use_by_resource_backend_resource_type_path({id: resourceTypeId})
