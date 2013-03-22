require 'csv'

class ImportsData
	def import
		measurements = []
		CSV.foreach("fixtures/austin-weather-data.csv", headers: true) do |row|
			measurements << WeatherMeasurement.new(row.to_hash)
		end
		return measurements
	end
end


class WeatherMeasurement
	attr_reader :rain, :temperature, :date
	def initialize(args)
	 @rain = args.fetch("PrecipitationIn").to_f
	 @temperature = args.fetch("Max TemperatureF").to_i
	 @date = Date.parse(args.fetch("CDT"))
	end
end
