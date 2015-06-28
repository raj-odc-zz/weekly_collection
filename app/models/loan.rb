class Loan < ActiveRecord::Base
  extend Enumerize
  belongs_to :customer
  has_many :daily_collections

  default_scope { order(order_no: :asc) }

  before_save :auto_increment
  before_create :auto_increment

  enumerize :loan_type,
            in: {Weekly: 1,
                 Daily: 2
            }, scope: true

  scope :weekly, -> { with_loan_type :Weekly }
  scope :daily, -> { with_loan_type :Daily }

  enumerize :vasool_day,
            in: {Sunday: 1,
                 Monday: 2,
                 Tuesday: 3,
                 Wednesday: 4,
                 Thursday: 5,
                 Friday: 6,
                 Saturday: 7
            }, scope: true

  scope :sunday, -> { with_vasool_day :Sunday }
  scope :monday, -> { with_vasool_day :Monday }
  scope :tuesday, -> { with_vasool_day :Tuesday }
  scope :wednesday, -> { with_vasool_day :Wednesday }
  scope :thursday, -> { with_vasool_day :Thursday }
  scope :friday, -> { with_vasool_day :Friday }
  scope :saturday, -> { with_vasool_day :Saturday }

  def auto_increment
    loan = Loan.find_by_order_no(self.order_no)
    if loan
      @loan_all = Loan.where("order_no >= #{self.order_no}")
      puts "+++++++++++++++++++++++++++",@loan_all.inspect
      @loan_all.each {|loan| loan.update_attribute(:order_no, loan.order_no+1)}
    end
  end
end
