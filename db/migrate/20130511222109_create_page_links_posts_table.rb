class CreatePageLinksPostsTable < ActiveRecord::Migration
	def self.up
		create_table :page_links_posts, :id => false do |t|
			t.integer :page_link_id
			t.integer :post_id
		end
	end

	def self.down
		drop_table :page_links_posts
	end
end
