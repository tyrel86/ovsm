class AddHasBooleansToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :has_video, :boolean
    add_column :posts, :has_audio, :boolean
    add_column :posts, :has_photos, :boolean
    add_column :posts, :has_links, :boolean
  end
end
