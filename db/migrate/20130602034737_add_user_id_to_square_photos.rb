class AddUserIdToSquarePhotos < ActiveRecord::Migration
  def change
    add_column :square_photos, :user_id, :integer
  end
end
