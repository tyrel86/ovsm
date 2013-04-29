class Forecast < ActiveRecord::Base
	include ForecastFetcher
  attr_accessible :forecast_io, :day_1_high, :day_1_icon, :day_1_low, :day_1_time, :day_2_high, :day_2_icon, :day_2_low, :day_2_time, :day_3_high, :day_3_icon, :day_3_low, :day_3_time, :day_4_high, :day_4_icon, :day_4_low, :day_4_time, :day_5_high, :day_5_icon, :day_5_low, :day_5_time, :day_6_high, :day_6_icon, :day_6_low, :day_6_time, :day_7_high, :day_7_icon, :day_7_low, :day_7_time
	belongs_to :feed

	after_create :update_forecast

	def each_day
		days = {}
		6.times do |i|
			day_number = i + 2
			day_name = send("day_#{day_number}_time").strftime("%A")
			days[day_name] = {}
			["high","low","icon"].each do |key|
				days[day_name][key] = send("day_#{day_number}_#{key}")
			end
		end

		#Intended use:
		# forecast.each_day{|day_name,values| "#{day_name}: #{values["high"]}" etc..
		days.each do |day|
			yield day.first, day.last
		end
	end

	def today
		day_name = day_1_time.strftime("%A")
		high = day_1_high
		low = day_1_low
		icon = day_1_icon
		{ name: day_name, high: high, low: low, icon: icon }
	end
end
