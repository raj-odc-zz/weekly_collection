class DailyCollection < ActiveRecord::Base
  belongs_to :loan
  belongs_to :user
  default_scope { order(collection_date: :desc) }

  scope :date_wise_report, ->(date) { includes(:loan).where(collection_date: date).order("loans.order_no ASC") }

  def date_with_name
    "#{date_format_view(collection_date)} - #{collection_date.strftime('%A')}"
  end

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

  def date_format_view(date)
    date.strftime('%d-%m-%Y')
  end
end
