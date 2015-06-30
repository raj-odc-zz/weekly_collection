json.array!(@customers) do |customer|
  json.extract! customer, :id, :name, :location, :mobile_number, :phone_number, :email_id, :address
  json.url customer_url(customer, format: :json)
end
