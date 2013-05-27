class CreateFeedVideos < ActiveRecord::Migration
  def change
    create_table :feed_videos do |t|
      t.integer :feed_id
      t.string :video
      t.boolean :active

      t.timestamps
    end
  end
end
