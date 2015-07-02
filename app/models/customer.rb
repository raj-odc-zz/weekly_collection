class Customer < ActiveRecord::Base
  has_many :loans, dependent: :destroy
  attr_accessor :name_location

  def name_location
    "#{self.name}-#{self.location}"
  end

  def self.search_by_name(query)
    where("lower(name) like ?", "%#{query.downcase}%")
  end

  def self.search_by_location(query)
    where("lower(location) like ?", "%#{query.downcase}%")
  end

  def self.search_name_location(query)
    where("lower(location) like ? OR lower(name) like ?", "%#{query.downcase}%","#{query.downcase}")
  end

end
