class CreateLandscapePhotos < ActiveRecord::Migration
  def change
    create_table :landscape_photos do |t|
      t.string :caption

      t.timestamps
    end
  end
end
