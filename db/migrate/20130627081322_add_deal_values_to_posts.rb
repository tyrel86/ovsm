class AddDealValuesToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :promo_price, :float
    add_column :posts, :promo_discounted_price, :float
    add_column :posts, :promo_description, :text
    add_column :posts, :promo_street_address, :string
    add_column :posts, :promo_city, :string
    add_column :posts, :promo_state, :string
    add_column :posts, :promo_zip, :string
    add_column :posts, :promo_start_date, :string
    add_column :posts, :promo_end_date, :string
    add_column :posts, :promo_labor_characteristic, :string
    add_column :posts, :promo_free, :boolean
    add_column :posts, :promo_wage, :float
    add_column :posts, :promo_wage_time, :string
    add_column :posts, :promo_shipping_cost, :float
    add_column :posts, :promo_href, :string
  end
end
