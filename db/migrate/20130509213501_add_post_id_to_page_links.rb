class AddPostIdToPageLinks < ActiveRecord::Migration
  def change
    add_column :page_links, :post_id, :integer
  end
end
