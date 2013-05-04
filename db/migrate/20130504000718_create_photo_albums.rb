class CreatePhotoAlbums < ActiveRecord::Migration
  def change
    create_table :photo_albums do |t|

      t.timestamps
    end
  end
end
