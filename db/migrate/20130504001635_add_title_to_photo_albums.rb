class AddTitleToPhotoAlbums < ActiveRecord::Migration
  def change
    add_column :photo_albums, :title, :string
  end
end
