json.array!(@loans) do |loan|
  json.extract! loan, :id, :customer_id, :order_no, :loan_type, :vasool_day, :given_date, :loan_amount, :given_amount, :installment_amount, :installments, :paid_amount, :balance_amount, :active_status
  json.url loan_url(loan, format: :json)
end
