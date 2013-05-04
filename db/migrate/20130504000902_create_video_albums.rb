class CreateVideoAlbums < ActiveRecord::Migration
  def change
    create_table :video_albums do |t|
      t.string :title

      t.timestamps
    end
  end
end
