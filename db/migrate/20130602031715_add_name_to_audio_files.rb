class AddNameToAudioFiles < ActiveRecord::Migration
  def change
    add_column :audio_files, :name, :string
  end
end
