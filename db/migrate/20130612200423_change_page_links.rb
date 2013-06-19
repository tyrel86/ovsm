class ChangePageLinks < ActiveRecord::Migration
  def self.up
		change_column :page_links, :title, :text
		change_column :page_links, :description, :text
		change_column :page_links, :image_url, :text
		change_column :page_links, :url, :text
  end
end
