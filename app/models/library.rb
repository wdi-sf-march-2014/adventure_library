class Library < ActiveRecord::Base
  has_many :adventures
  validates :url, uniqueness: true #ensures that we don't scrape the same library twice
end
