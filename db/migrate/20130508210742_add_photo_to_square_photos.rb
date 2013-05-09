class AddPhotoToSquarePhotos < ActiveRecord::Migration
  def change
    add_column :square_photos, :photo, :string
  end
end
