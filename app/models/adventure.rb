class Adventure < ActiveRecord::Base
  has_many :pages
  belongs_to :library

  validates :title, length: { minimum: 4 }

  validates :guid, presence: true, length: { is: 10 }

end
