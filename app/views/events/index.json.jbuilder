json.array!(@events) do |event|
  json.extract! event, :id, :nombre
  json.url event_url(event, format: :json)
end
