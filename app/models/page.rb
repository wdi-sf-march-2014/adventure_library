class Page < ActiveRecord::Base
  belongs_to :adventure
  accepts_nested_attributes_for :adventure
end
