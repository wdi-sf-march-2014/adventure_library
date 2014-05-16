class Adventure < ActiveRecord::Base
  belongs_to :library
  has_many :pages
  before_save :create_guid

  def create_guid
    self.guid ||= SecureRandom.urlsafe_base64(10)
  end
end

