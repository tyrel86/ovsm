class AddZenMetaToAudioFiles < ActiveRecord::Migration
  def change
    add_column :audio_files, :zen_meta, :hstore
  end
end
