class AddFeedIdToForecasts < ActiveRecord::Migration
  def change
    add_column :forecasts, :feed_id, :integer
  end
end
