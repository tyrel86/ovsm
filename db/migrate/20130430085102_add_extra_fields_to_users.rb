class AddExtraFieldsToUsers < ActiveRecord::Migration
  def change
    add_column :users, :name, :string
    add_column :users, :username, :string
    add_column :users, :interest_id, :integer
    add_column :users, :birthday, :date
  end
end
