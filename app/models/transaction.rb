class Transaction < ActiveRecord::Base

  scope :by_date, ->(date) { where(:entry_date => date) }

  def self.create_update(date,entries)
    puts "entries",entries.inspect
    transaction = Transaction.find_or_initialize_by(entry_date: date)

      transaction.opening_balance = entries[:opening_balance]
      transaction.collection_amount = entries[:collection]
      transaction.other_income = entries[:total_incomes]
      transaction.new_loan = entries[:new_loan]
      transaction.other_expenses = entries[:total_expenses]
      transaction.closing_balance = entries[:closing_balance]

    transaction.save
  end
end
