class AddAwsUrlsToVideoFiles < ActiveRecord::Migration
  def change
    add_column :video_files, :aws_urls, :hstore
  end
end
