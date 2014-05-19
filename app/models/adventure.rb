class Adventure < ActiveRecord::Base
  has_many :pages, dependent: :destroy
  belongs_to :library
  accepts_nested_attributes_for :pages

  def self.is_local?
    adventure.library_id.nil?
  end
end
