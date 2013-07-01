module ForecastFetcher
  extend ActiveSupport::Concern

  included do
  end

	def fetch_weather_data
		parrent_feed = feed
		lat = parrent_feed.lat
		lng = parrent_feed.lng
		uri = "https://api.forecast.io/forecast/#{ForecastFetcher.api_key}/#{lat},#{lng}"
		puts uri
		begin
			json_data = JSON.parse( open(uri).read )
		rescue
			#Email system admin
		end
	end

	def update_forecast
		json_data = fetch_weather_data
		daily_data = json_data['daily']['data']
		daily_data.pop
		value_suffixes = {"time" => "time","low" => "temperatureMin", "high" => "temperatureMax", "icon" => "icon"}
		daily_data.each_with_index do |data,index|
			i = index + 1
			value_suffixes.keys.each do |suffix|
				message = "day_#{i}_#{suffix}"
				value = data[value_suffixes[suffix]]
				value = Time.at( value ) if suffix == "time"
				send("#{message}=", value )
			end
		end
		save
	end

  module ClassMethods
  end

	class << self
		attr_accessor :api_key
	end
end
