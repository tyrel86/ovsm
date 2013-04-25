class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :name
      t.float :lat
      t.float :lng

      t.timestamps
    end
  end
end
