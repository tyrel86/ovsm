class AddForecastIdToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :forecast_id, :integer
  end
end
