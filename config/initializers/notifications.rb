ActiveSupport::Notifications.subscribe 'mybookings_info.record_created' do |name, start, finish, id, payload|
  object = payload[:object]
  object.log_for_record_created(name, finish)
end

ActiveSupport::Notifications.subscribe 'mybookings_info.record_updated' do |name, start, finish, id, payload|
  object = payload[:object]
  object.log_for_record_updated(name, finish)
end
