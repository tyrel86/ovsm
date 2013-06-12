class AddReadyToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :ready, :boolean
  end
end
