json.array!(@photos) do |photo|
  json.extract! photo, :id, :nombre
  json.url photo_url(photo, format: :json)
end
