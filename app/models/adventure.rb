class Adventure < ActiveRecord::Base
  belongs_to :library
  has_many :pages

  # Validating the title is present and the length of the title is between 2 and 200
  validates :title, presence: true, length: {minimum: 2, maximum: 200}

  # Validating the title is present and the length of the title is between 2 and 200
  validates :author, presence: true, length: {minimum: 2, maximum: 200}

  validates :guid, presence: true, length: {is: 10}
end
