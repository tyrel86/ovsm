class AddActiveToFeedBanners < ActiveRecord::Migration
  def change
    add_column :feed_banners, :active, :boolean
  end
end
