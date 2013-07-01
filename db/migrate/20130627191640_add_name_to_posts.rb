class AddNameToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :promo_name, :string
  end
end
