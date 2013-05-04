class CreateSquarePhotos < ActiveRecord::Migration
  def change
    create_table :square_photos do |t|
      t.string :caption

      t.timestamps
    end
  end
end
