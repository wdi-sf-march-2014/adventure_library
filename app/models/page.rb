class Page < ActiveRecord::Base
  has_many :pages
  belongs_to :Adventure
end
