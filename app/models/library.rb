class Library < ActiveRecord::Base
  has_many: adventures
  has_many: pages 
end
