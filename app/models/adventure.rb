class Adventure < ActiveRecord::Base
  belongs_to :library
  has_many :pages
  accepts_nested_attributes_for :pages
  before_save :create_guid
  validates :guid, uniqueness: true
  validates :title, presence: true
  validates :author, presence: true

  def create_guid
    self.guid ||= SecureRandom.urlsafe_base64(10)
  end
end

