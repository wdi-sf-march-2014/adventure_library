class Library < ActiveRecord::Base
  has_many :adventures
  accepts_nested_attributes_for :adventures
end
