class Loan < ActiveRecord::Base
  extend Enumerize
  belongs_to :customer
  enumerize :loan_type,
            in: {weekly: 1,
                 daily: 2
            }, scope: true

  scope :weekly, -> { with_loan_type :weekly }
  scope :daily, -> { with_loan_type :daily }

  enumerize :vasool_day,
            in: {sunday: 1,
                 monday: 2,
                 tuesday: 3,
                 wednesday: 4,
                 thursday: 5,
                 friday: 6,
                 saturday: 7
            }, scope: true

  scope :sunday, -> { with_vasool_day :sunday }
  scope :monday, -> { with_vasool_day :monday }
  scope :tuesday, -> { with_vasool_day :tuesday }
  scope :wednesday, -> { with_vasool_day :wednesday }
  scope :thursday, -> { with_vasool_day :thursday }
  scope :friday, -> { with_vasool_day :friday }
  scope :saturday, -> { with_vasool_day :saturday }


end
