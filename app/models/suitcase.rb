class Suitcase < ActiveRecord::Base
	serialize :posts, ActiveRecord::Coders::Hstore
  attr_accessible :name, :posts, :user_id
	belongs_to :user

	def add_post( post_id )
		unless has_post?( post_id )
			begin
				Post.find( post_id )
				self.posts[post_id.to_s] = post_id
				result = :success
			rescue
				result = :post_does_not_exsist
			end
		else
			result = :already_in_suitcase
		end
		result
	end

	def remove_post( post_id )
		if has_post?( post_id )
			begin
				Post.find( post_id )
				self.posts.remove!(post_id.to_s)
				result = :success
			rescue
				result = :post_does_not_exsist
			end
		else
			result = :post_not_in_suitcase
		end
		result
	end

	def has_post?( post_id )
		post_ids.include?( post_id )
	end

	def post_ids
		posts.values.map {|e| e.to_i}
	end
end
