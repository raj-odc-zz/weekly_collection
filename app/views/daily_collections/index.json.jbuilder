json.array!(@daily_collections) do |daily_collection|
  json.extract! daily_collection, :id, :loan_id, :amount, :user_id
  json.url daily_collection_url(daily_collection, format: :json)
end
