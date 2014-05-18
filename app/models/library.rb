class Library < ActiveRecord::Base
	
	has_many :adventures, dependent: :destroy
	accepts_nested_attributes_for :adventures

end
