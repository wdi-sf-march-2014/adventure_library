class Adventure < ActiveRecord::Base
  has_many :pages
  belongs_to :library
  accepts_nested_attributes_for :pages

  # validates :title, length: { minimum: 4 }

  # validates :author, length: { minimum: 3 }

  # validates :guid, presence: true, length: { is: 10 }

end
