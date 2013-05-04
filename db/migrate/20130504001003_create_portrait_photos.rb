class CreatePortraitPhotos < ActiveRecord::Migration
  def change
    create_table :portrait_photos do |t|
      t.string :caption

      t.timestamps
    end
  end
end
