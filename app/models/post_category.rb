class PostCategory < ActiveRecord::Base
  attr_accessible :helper, :name
	has_many :posts
end
