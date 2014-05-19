class Adventure < ActiveRecord::Base
  has_many :pages
  belongs_to :library
  accepts_nested_attributes_for :pages

  #validates :guid, presence: true, length: {minimum: 6}

  # before_validation do |adv|
  #   adv.guid = SecureRandom.urlsafe_base64(10)
  # end

  def as_json(options={})
    super(:except => [:id])
  end

end
