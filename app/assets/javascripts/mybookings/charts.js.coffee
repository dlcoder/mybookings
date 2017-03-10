window.Mybookings ||= {}

class Mybookings.Charts

  @selector: ''
  @resourceTypeInputSelector: ''
  @typeChart: ''

  @render: (typeChart, selector, resourceTypeInputSelector) ->
    return if $(selector).html()

    Charts.selector = selector
    Charts.resourceTypeInputSelector = resourceTypeInputSelector
    Charts.typeChart = typeChart

    getData(drawBarChar) if typeChart == 'bar'
    getData(drawLineChar) if typeChart == 'line'


  drawLineChar = (dataset) ->
    options = {
      plugins: [
        ctLineLabels({
          textAnchor: 'middle'
        })
      ]
    }

    new Chartist.Line(Charts.selector, dataset, options)
    registerChangeHandler()

  drawBarChar = (dataset) ->
    options = {
      distributeSeries: true,
      plugins: [
        ctBarLabels({
          labelClass: 'ct-bar-label',
          textAnchor: 'middle'
        })
      ]
    }

    new Chartist.Bar(Charts.selector, dataset, options)
    registerChangeHandler()

  getData = (callBack) ->
    resourceTypeId = $(Charts.resourceTypeInputSelector).val();

    url = "/backend/resource_types/#{resourceTypeId}/use_by_hour.json" if Charts.typeChart == 'line'
    url = "/backend/resource_types/#{resourceTypeId}/use_by_resource.json" if Charts.typeChart == 'bar'

    $.getJSON(url)
      .done((data) -> callBack(data))

  registerChangeHandler =->
    $(Charts.resourceTypeInputSelector).on 'change', ->
      getData((dataset) -> $(Charts.selector).get(0).__chartist__.update(dataset))

