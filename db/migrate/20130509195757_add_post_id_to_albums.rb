class AddPostIdToAlbums < ActiveRecord::Migration
  def change
    add_column :photo_albums, :post_id, :integer
    add_column :audio_albums, :post_id, :integer
    add_column :video_albums, :post_id, :integer
  end
end
