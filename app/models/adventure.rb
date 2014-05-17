class Adventure < ActiveRecord::Base
	has_many :pages
	belongs_to :library
	# if library_id is nil, adventure is local

	#before_save :add_guid

	# validates :GUID, uniqueness: true, presence: true, length: { minimum: 10 }
	validates :title, presence: true
	validates :author, presence: true

end
