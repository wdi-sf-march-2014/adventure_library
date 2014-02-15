class Adventure < ActiveRecord::Base
  has_many :pages

  def start
    pages.find_by(:name => "start")
  end

  def as_json(opts={})
    default_opts = {:only => [:title, :created_at, :updated_at, :guid, :author],
                    :include => [{:pages => {:only => [:name, :text]}}]}
    super(default_opts.merge(opts))
  end

end