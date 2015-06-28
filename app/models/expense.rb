class Expense < ActiveRecord::Base
  belongs_to :expense_type
  belongs_to :user
end
