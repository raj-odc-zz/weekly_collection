class BulkImport < ActiveRecord::Base
  scope :today, -> { where(:collection_date => Date.today) }
end
