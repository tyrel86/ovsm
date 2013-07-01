class AddPromoTypeToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :promo_type, :string
  end
end
