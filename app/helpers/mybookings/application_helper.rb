module Mybookings
  module ApplicationHelper
    def resource_name
      :user
    end

    def resource
      @resource ||= User.new
    end

    def devise_mappings
      @devise_mappings ||= Devise.mappings[:user]
    end

    def resource_class
      User
    end

    def title title=t('.title')
      title_for_html title
      title_for_page title
    end

    def title_for_html title=t('.title')
      content_for :html_title, "#{ title } - #{ t('mybookings.app_name') }"
    end

    def title_for_page title=t('.title')
      content_for :page_title, title
    end

    def table_for collection, partial, attr_list = [], id = nil
      actions = true

      table_headers = []

      attr_list.each do |attr_name|
        if attr_name.class == Hash && !attr_name[:actions].nil?
          actions = attr_name[:actions]
        else
          table_headers << content_tag(:th, t("activerecord.attributes.mybookings/#{attr_name}"))
        end
      end

      if actions
        table_headers << content_tag(:th, t('actions'))
      end

      thead = content_tag :thead, content_tag(:tr, table_headers.join(" ").html_safe)
      if partial
        tbody = content_tag :tbody, render(collection: collection, partial: partial)
      else
        tbody = content_tag :tbody, render(collection)
      end

      table = content_tag(:table, "#{thead} #{tbody}".html_safe, id: id, class: 'table table-bordered')
      table_responsive = content_tag(:div, table.html_safe, class: 'table-responsive')

      table_responsive.html_safe
    end

    def link_to_delete text, path, title, options={}
      link_to_verb :delete, text, path, title, { icon: 'remove' }.merge(options)
    end

    def icon_with_text icon_name, text
      return text if icon_name.blank?

      icon = content_tag :span, '', class: "glyphicon glyphicon-#{icon_name}"
      "#{icon} #{text}".html_safe
    end

    def render_flash_messages
      flash_class = { 'notice' => 'alert-success', 'alert' => 'alert-danger' }

      flash.map do |name, message|
        next if message.blank?

        content_tag :div, class: "alert alert-dismissable #{flash_class[name]}" do
          dismiss_button = content_tag :button, type: 'button', class: 'close', 'data-dismiss' => 'alert', 'aria-hidden' => 'true' do
            '&times;'.html_safe
          end

          "#{dismiss_button} #{message}".html_safe
        end
      end.join('').html_safe
    end

    def render_model_base_errors object
      if object.errors[:base].any?
        object.errors[:base].map do |message|
          next if message.blank?

          content_tag :div, class: 'alert alert-danger' do
            message.html_safe
          end
        end.join('').html_safe
      end
    end

    def asset_exist?(path)
      if Rails.configuration.assets.compile
        Rails.application.precompiled_assets.include? path
      else
        Rails.application.assets_manifest.assets[path].present?
      end
    end

    private

    def link_to_verb verb, text, path, title, options={}
      icon = options.delete(:icon)
      link_to icon_with_text(icon, text), path, { data: { confirm: title }, method: verb }.merge(options)
    end
  end
end
