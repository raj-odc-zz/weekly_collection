json.array!(@expenses) do |expense|
  json.extract! expense, :id, :expense_type_id, :amount, :user_id
  json.url expense_url(expense, format: :json)
end
