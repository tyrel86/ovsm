class AddFileToAudioFiles < ActiveRecord::Migration
  def change
    add_column :audio_files, :file, :string
  end
end
