class Customer < ActiveRecord::Base
  has_many :loans, dependent: :destroy
  attr_accessor :name_location

  paginates_per 20
  scope :active, -> { where(:active_status => true) }
  scope :inactive, -> { where(:active_status => false) }

  scope :search_name, ->(name) { where('lower(name) like ?', "%#{name.downcase}%") }

  scope :search_location, ->(location) { where('lower(location) like ?', "%#{location.downcase}%") }

  def name_location
    "#{self.name}-#{self.location}"
  end

  def self.search_name_location(query)
    where("lower(location) like ? OR lower(name) like ?", "%#{query.downcase}%","#{query.downcase}")
  end

end
