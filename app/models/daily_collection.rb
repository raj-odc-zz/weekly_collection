class DailyCollection < ActiveRecord::Base
  belongs_to :loan
  belongs_to :user

  paginates_per 10

  #default_scope { includes(:loan).order("loans.order_no ASC") }

  def balance_correction(params_amount)
    balance = loan.balance_amount
    balance = balance - (params_amount.to_f - amount.to_f)
    loan.update_balance_amount(balance)
    update(:amount => params_amount)
    self
  end

  def self.total_amount(date)
    where(:collection_date => date).map(&:amount).reduce(:+) || 0
  end
end
