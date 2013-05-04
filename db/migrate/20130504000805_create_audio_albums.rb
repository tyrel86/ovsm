class CreateAudioAlbums < ActiveRecord::Migration
  def change
    create_table :audio_albums do |t|
      t.string :title

      t.timestamps
    end
  end
end
