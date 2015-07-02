class Customer < ActiveRecord::Base
  has_many :loans, dependent: :destroy
  attr_accessor :name_location

  def name_location
    "#{self.name}-#{self.location}"
  end
end