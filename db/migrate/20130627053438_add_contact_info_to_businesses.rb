class AddContactInfoToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :phone, :string
    add_column :businesses, :street_address, :string
    add_column :businesses, :state, :string
    add_column :businesses, :zip_code, :string
  end
end
