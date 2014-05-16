class Adventure < ActiveRecord::Base
	has_many :pages
	belongs_to :library
	# if library_id is nil, adventure is local
end
