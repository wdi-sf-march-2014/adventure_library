class Adventure < ActiveRecord::Base
	has_many :pages
	belongs_to :library
	accepts_nested_attributes_for :pages
	# if library_id is nil, adventure is local

	# validates :GUID, uniqueness: true, presence: true, length: { minimum: 10 }
	validates :title, presence: true
	validates :author, presence: true

end
