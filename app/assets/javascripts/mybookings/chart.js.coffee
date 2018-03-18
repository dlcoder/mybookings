class Mybookings.Chart
  constructor: (@selector, @resourceTypeInputSelector) ->

  render: ->
    @getData(@drawChar)

  drawChar: (dataset) =>
    @registerChangeHandler()

  getData:(callBack) ->
    url = @getUrl()
    $.getJSON(url).done((data) -> callBack(data))

  getUrl: ->

  registerChangeHandler: ->
    $(@resourceTypeInputSelector).on 'change', =>
      @getData((dataset) => $(@selector).get(0).__chartist__.update(dataset))
