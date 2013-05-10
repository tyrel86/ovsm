class AddPromotionalToPost < ActiveRecord::Migration
  def change
    add_column :posts, :promotional, :boolean
  end
end
