class AddPhotoToPortraitPhotos < ActiveRecord::Migration
  def change
    add_column :portrait_photos, :photo, :string
  end
end
