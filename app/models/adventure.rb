class Adventure < ActiveRecord::Base
  belongs_to :library
  has_many :pages

  #  def as_json(options={})
  #   {
  #     :title => title,
  #     :author => author,
  #     :GUID => GUID,
  #     :created_at => created_at,
  #     :updated_at => updated_at
  #   }
  # end
end
