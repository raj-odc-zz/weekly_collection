class EntryType < ActiveRecord::Base
  has_many :entries, dependent: :destroy


  scope :incomes, -> { where(income: true) }
  scope :expenses, -> { where(income: false) }

end
