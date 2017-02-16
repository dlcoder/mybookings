json.array! @events do |event|
  json.title "#{event.resource_resource_type_name} - #{event.resource_name}"
  json.start event.start_date.iso8601
  json.end event.end_date.iso8601
  json.url booking_path(event.booking)
  json.color '#f0ad4e' if event.pending?
  json.color '#5bc0de' if event.occurring?
  json.color '#5cb85c' if event.expired?
end
