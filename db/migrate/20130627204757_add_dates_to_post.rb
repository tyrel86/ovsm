class AddDatesToPost < ActiveRecord::Migration
  def change
    add_column :posts, :promo_start_date, :date
    add_column :posts, :promo_end_date, :date
    add_column :posts, :promo_contact_email, :string
  end
end
