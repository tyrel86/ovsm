class AddAwsUrlsToAudioFiles < ActiveRecord::Migration
  def change
    add_column :audio_files, :aws_urls, :hstore
  end
end
