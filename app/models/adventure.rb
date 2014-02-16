class Adventure < ActiveRecord::Base
  has_many :pages
  accepts_nested_attributes_for :pages

  validates_uniqueness_of :guid, :scope => :library_id
    
  def start
    pages.find_by(:name => "start")
  end

  def as_json(opts={})
    default_opts = {:only => [:title, :created_at, :updated_at, :guid, :author],
                    :include => [{:pages => {:only => [:name, :text]}}]}
    super(default_opts.merge(opts))
  end
  before_validation :set_guid, :on => :create
  def set_guid
    self.guid ||= SecureRandom.urlsafe_base64(10)
  end
end