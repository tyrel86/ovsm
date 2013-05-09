class AddPhotoToLandscapePhotos < ActiveRecord::Migration
  def change
    add_column :landscape_photos, :photo, :string
  end
end
