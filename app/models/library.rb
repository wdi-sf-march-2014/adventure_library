class Library < ActiveRecord::Base
  has_many :adventures

  def as_json(options={})
    super(:except => [:id])
  end
  
end
