module BookingsHelper
  def bootstrap_class_for booking_status
    return 'warning' if booking_status == 'pending'
    return 'info' if booking_status == 'occurring'
    return 'success' if booking_status == 'expired'
  end

  def show_specific_actions_for booking
    resource_type_extension_actions = ResourceTypesExtensionsWrapper.call(:actions_for, booking)
    links = ''

    unless resource_type_extension_actions.nil?
      resource_type_extension_actions.each do |action|
        action[:target] ||= '_self'

        link = link_to icon_with_text(action[:icon], action[:text]), action[:path], target: action[:target], class: 'btn btn-default btn-xs'

        links << link
      end
    end

    links.html_safe
  end
end
