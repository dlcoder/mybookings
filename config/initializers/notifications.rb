ActiveSupport::Notifications.subscribe 'mybookings_info.record_created' do |name, start, finish, id, payload|

  case payload[:object]
    when Booking
      booking = payload[:object]
      Rails.logger.info "#{finish} - #{name}: New Booking of resource #{booking.resource_id} (#{booking.resource_name}, #{booking.resource_resource_type_name}) by user with email #{booking.user_email}."
    else
      Rails.logger.info "#{finish} - #{name}: New #{payload[:object].class.name}"
  end

end

ActiveSupport::Notifications.subscribe 'mybookings_info.record_updated' do |name, start, finish, id, payload|

  Rails.logger.info "#{finish} - #{name}: #{payload[:object].class.name} #{payload[:object].id} updated."

end
