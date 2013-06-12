class AddPostIdToPandaUploads < ActiveRecord::Migration
  def change
    add_column :panda_uploads, :post_id, :integer
  end
end
