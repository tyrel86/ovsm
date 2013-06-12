class AddPandaMetaToPosts < ActiveRecord::Migration
  def change
    add_column :posts, :panda_meta, :hstore
  end
end
