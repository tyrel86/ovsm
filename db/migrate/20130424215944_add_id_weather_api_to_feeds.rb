class AddIdWeatherApiToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :id_for_weather_api, :integer
  end
end
