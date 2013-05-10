class AddAlbumIdsToAlbumFiles < ActiveRecord::Migration
  def change
    add_column :square_photos, :photo_album_id, :integer
    add_column :audio_files, :audio_album_id, :integer
    add_column :video_files, :video_album_id, :integer
  end
end
