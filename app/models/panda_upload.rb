class PandaUpload < ActiveRecord::Base
  attr_accessible :panda_id, :media_type
	belongs_to :post
end
