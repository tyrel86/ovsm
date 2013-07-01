class AddCityToBusiness < ActiveRecord::Migration
  def change
    add_column :businesses, :city, :string
  end
end
