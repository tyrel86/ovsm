class AddTimeZoneToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :time_zone, :string
  end
end
