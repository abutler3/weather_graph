require "./austin-data"

describe ImportsData do
  it "should have 366 entries" do
    ImportsData.new.import.count.should eq(366)
	end

  it "should return a WeatherMeasurement" do
	 ImportsData.new.import.first.should be_a(WeatherMeasurement)
  end

  it "should have the right measurements for nov 28" do
	measurements = ImportsData.new.import
	nov_28 = measurements.select{|measurement| measurement if measurement.date == Date.parse("2011-11-28")}.first
   nov_28.rain.should eq(0.00)
	nov_28.temperature.should eq(63)
  end
end

describe WeatherMeasurement do
  describe "#rain" do
  	let(:weather_data) { {"PrecipitationIn" => "0.10", "Max TemperatureF" => 95, "CDT" => "2011-3-28"} }
  	it "fetches rain and stores it" do
	 WeatherMeasurement.new(weather_data).rain.should eq(0.10)
	end
	it "fetches the temperature and stores it" do
	 WeatherMeasurement.new(weather_data).temperature.should eq(95)
   end
   it "fetches the data and stores id" do
	 WeatherMeasurement.new(weather_data).date.should eq(Date.parse("2011-3-28"))
   end
  end
end
