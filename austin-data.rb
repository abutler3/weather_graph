require 'csv'

class ImportsData
	def import
		measurements = []
		CSV.foreach("fixtures/austin-weather-data.csv", headers: true) do |row|
			measurements << WeatherMeasurement.new(row)
		end
		return measurements
	end
end


class WeatherMeasurement
	def initialize(arg)
	end
end
