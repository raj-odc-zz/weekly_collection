json.array!(@entries) do |entry|
  json.extract! entry, :id, :entry_type_id, :user_id, :amount, :entry_date
  json.url entry_url(entry, format: :json)
end
