class Adventure < ActiveRecord::Base
	before_create :create_guid

	validates :title, presence: true
  validates :author, presence: true
  validates_uniqueness_of :guid

  belongs_to :library
  has_many :pages, dependent: :destroy
  accepts_nested_attributes_for :pages, reject_if: lambda { |a| a[:name].blank? }, :allow_destroy => true

private
  	def create_guid
			self.guid ||= SecureRandom.urlsafe_base64(10).to_s
		end
end
