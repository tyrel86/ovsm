class AddUrlToPageLinks < ActiveRecord::Migration
  def change
    add_column :page_links, :url, :string
  end
end
