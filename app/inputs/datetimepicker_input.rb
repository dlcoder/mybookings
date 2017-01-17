class DatetimepickerInput < SimpleForm::Inputs::Base
  def input(wrapper_options)
    input_html_options[:class].push 'form-control'

    addon = "<span class='glyphicon glyphicon-calendar'></span>"
    addon_group_addon = "<div class='input-group-addon'>#{addon}</div>"
    input = "#{@builder.text_field(attribute_name, input_html_options)}"
    input_group = "<div class='input-group'>#{addon_group_addon}#{input}</div>".html_safe
  end
end
