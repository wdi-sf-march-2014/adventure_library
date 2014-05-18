class Page < ActiveRecord::Base
  belongs_to :adventure
  validates :name, presence: true, length: { minimum: 1, maximum: 255 }
  validates :text, presence: true
end
