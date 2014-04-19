module ApplicationHelper

  def title title=t('.title')
    title_for_html title
    title_for_page title
  end

  def title_for_html title=t('.title')
    content_for :html_title, "#{ title } - #{ t('app_name') }"
  end

  def title_for_page title=t('.title')
    content_for :page_title, title
  end

  def table_for collection, *attr_list
    actions = true

    table_id = collection.name.tableize
    table_klazz = collection.name.constantize
    table_headers = []

    attr_list.each do |attr_name|
      if attr_name.class == Hash && !attr_name[:actions].nil?
        actions = attr_name[:actions]
      else
        table_headers << content_tag(:th, table_klazz.human_attribute_name(attr_name))
      end
    end

    if actions
      table_headers << content_tag(:th, t('actions'))
    end

    thead = content_tag :thead, content_tag(:tr, table_headers.join(" ").html_safe)
    tbody = content_tag :tbody, render(collection)

    table = content_tag(:table, "#{thead} #{tbody}".html_safe, id: table_id, class: 'table table-bordered table-striped')
    table.html_safe
  end

  def link_to_delete text, path, title, options={}
    link_to_verb :delete, text, path, title, { icon: 'remove' }.merge(options)
  end

  def icon_with_text icon_name, text
    return text if icon_name.blank?

    icon = content_tag :span, '', class: "glyphicon glyphicon-#{icon_name}"
    "#{icon} #{text}".html_safe
  end

  private

  def link_to_verb verb, text, path, title, options={}
    icon = options.delete(:icon)
    link_to icon_with_text(icon, text), path, { data: { confirm: title }, method: verb }.merge(options)
  end

end
