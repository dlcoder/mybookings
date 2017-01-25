json.array! @events do |event|
  json.id  event.id
  json.title "Ocupado"
  json.start event.start_date.rfc822
  json.end  event.end_date.rfc822
  json.color "red"
end
