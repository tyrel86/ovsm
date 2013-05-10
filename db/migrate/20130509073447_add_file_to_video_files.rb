class AddFileToVideoFiles < ActiveRecord::Migration
  def change
    add_column :video_files, :file, :string
  end
end
