class AddBusinessIdToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :business_id, :integer
  end
end
