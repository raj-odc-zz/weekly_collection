class Entry < ActiveRecord::Base
  belongs_to :entry_type
  belongs_to :user

  scope :incomes, lambda {
                  joins(:entry_type).where('entry_types.income = true')
                }
  scope :expenses, lambda {
                   joins(:entry_type).where('entry_types.income = false')
                 }

  scope :by_date, ->(date) { where(:entry_date => date) }

  scope :desc, -> { order created_at: :desc }

  def type
    entry_type
  end

  def set_name
    self.name = type.name if name.blank? || name.nil?
  end

  def self.total_amount
    all.map(&:amount).reduce(:+) || 0
  end
end
