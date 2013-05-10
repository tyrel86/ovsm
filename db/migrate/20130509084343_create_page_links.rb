class CreatePageLinks < ActiveRecord::Migration
  def change
    create_table :page_links do |t|
      t.string :title
      t.string :description
      t.string :image_url

      t.timestamps
    end
  end
end
