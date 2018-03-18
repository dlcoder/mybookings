class Mybookings.DynamicForm
  @ENABLES_DATA_ATTRIBUTE: 'dynamic-form-enables-with'
  @DISABLES_DATA_ATTRIBUTE: 'dynamic-form-disables-with'
  @ENABLES_SELECTOR: '[data-dynamic-form-enables-with]'
  @DISABLES_SELETOR: '[data-dynamic-form-disables-with]'
  @HIDE_ELEMENT_SELECTOR: '.js-dynamic-form-element-to-hide'

  constructor: (form, events='change') ->
    @form = form
    $(@form).on events, @handleChange
    @render()

  handleChange: (event) =>
    @render()

  render: ->
    @processEnableElementsInForm()
    @processDisableElementsInForm()

  processEnableElementsInForm: ->
    for element in @findEnableElementsInForm()
      if @passConditions(element, DynamicForm.ENABLES_DATA_ATTRIBUTE)
        @makeVisible(element)
      else
        @makeInvisible(element)

  processDisableElementsInForm: ->
    for element in @findDisableElementsInForm()
      if @passConditions(element, DynamicForm.DISABLES_DATA_ATTRIBUTE)
        @makeInvisible(element)
      else
        @makeVisible(element)

  findEnableElementsInForm: ->
    $(DynamicForm.ENABLES_SELECTOR, $(@form)).get().reverse()

  findDisableElementsInForm: ->
    $(DynamicForm.DISABLES_SELETOR, $(@form)).get().reverse()

  passConditions: (element, attribute) ->
    conditions = $(element).data(attribute)
    [selector, values] = conditions.split('=')
    options = values.split('||')
    options.indexOf($(selector).val()) != -1

  makeVisible: (element) ->
    $(element).prop('disabled', false)
    $(element).closest(DynamicForm.HIDE_ELEMENT_SELECTOR).show()

  makeInvisible: (element) ->
    $(element).prop('disabled', true)
    $(element).closest(DynamicForm.HIDE_ELEMENT_SELECTOR).hide()

$(document).on 'turbolinks:load', ->
  $.map $('[data-behavior~="dynamic-form"]'), (item) ->
    new Mybookings.DynamicForm(item, 'change')
