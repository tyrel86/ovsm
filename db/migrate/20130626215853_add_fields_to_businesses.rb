class AddFieldsToBusinesses < ActiveRecord::Migration
  def change
    add_column :businesses, :business_name, :string
    add_column :businesses, :business_banner, :string
    add_column :businesses, :business_logo, :string
  end
end
