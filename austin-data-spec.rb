require "./austin-data"

describe ImportsData do
  it "should have 366 entries" do
    ImportsData.new.import.count.should eq(366)
	end

  it "should return a WeatherMeasurement" do
	 ImportsData.new.import.first.should be_a(WeatherMeasurement)
  end
end
