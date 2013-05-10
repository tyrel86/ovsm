class AddAsociationIdsToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :feed_id, :integer
    add_column :posts, :user_id, :integer
  end
end
