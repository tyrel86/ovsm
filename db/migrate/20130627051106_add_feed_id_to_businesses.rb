class AddFeedIdToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :feed_id, :integer
  end
end
