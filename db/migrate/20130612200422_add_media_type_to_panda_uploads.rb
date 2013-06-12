class AddMediaTypeToPandaUploads < ActiveRecord::Migration
  def change
    add_column :panda_uploads, :media_type, :string
  end
end
