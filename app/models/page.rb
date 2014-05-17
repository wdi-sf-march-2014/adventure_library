class Page < ActiveRecord::Base
	belongs_to :adventure
	include PagesHelper
end
