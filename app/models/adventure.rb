class Adventure < ActiveRecord::Base
  has_many :pages, dependent: :destroy
  belongs_to :library

  def self.is_local?
    adventure.library_id.nil?
  end
end
