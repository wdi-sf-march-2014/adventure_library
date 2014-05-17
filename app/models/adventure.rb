class Adventure < ActiveRecord::Base
	has_many :pages
	belongs_to :library
	accepts_nested_attributes_for :pages

validates :title, presence: true, length: {minimum: 2}

validates :author, presence: true, length: {minimum: 2}

# validates :guid, presence: true, length: {is: 10}

end