class AddPromoImageToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :promo_image, :string
  end
end
