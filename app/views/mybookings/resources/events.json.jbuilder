json.array! @events do |event|
  json.title t('.status')
  json.start event.start_date.iso8601
  json.end  event.end_date.iso8601
  json.color "red"
end
