class Library < ActiveRecord::Base
	has_many :adventures

	validates :URL, uniqueness: true, presence: true 
end

