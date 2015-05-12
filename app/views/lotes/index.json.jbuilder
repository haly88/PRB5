json.array!(@lotes) do |lote|
  json.extract! lote, :id, :nombre
  json.url lote_url(lote, format: :json)
end
