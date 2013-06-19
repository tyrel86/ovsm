class CreateSuitcases < ActiveRecord::Migration
  def change
    create_table :suitcases do |t|
      t.string :name
      t.integer :user_id
      t.hstore :posts

      t.timestamps
    end
  end
end
