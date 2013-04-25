class CreateFeedBanners < ActiveRecord::Migration
  def change
    create_table :feed_banners do |t|
      t.integer :feed_id
      t.string :image

      t.timestamps
    end
  end
end
