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
 describe WeatherChart do
  let(:measurements) { [stub({ :rain => 0.0, :temperature => 64, :date => Date.parse("2011-3-28") })] } 
  	it "should create an array of data points" do
		WeatherChart.new.create(measurements).should include "['Mar28', 0.0, 64]"
	end

	it "should get the template" do
		WeatherChart.new.create(measurements).should include "google.visualization.LineChart"
	end
	
	let(:file_path) { "/tmp/austin_chart.html" }
	# File path we want it to write to
	let(:fake_html) { "fake-html" }
   # Fake out the html because all we care about is message passing
	it "should write to a file" do
	  chart = WeatherChart.new
	  chart.stub(:create) { fake_html }
     # Stub the html and return the fake_html
	  file_mock = mock("file")
     # We are creating the idea of a file object. Mock out the idea of a file
	  file_mock.stub(:write).with(fake_html)
     # Mock should receive write with fake_html
	  File.should_receive(:open).with(file_path, "w") { file_mock }
	  # Stub out the file class whenever we receive it with file_path, w and return file mock
     # Whenever we tell file to open this path with the file attributes, it is going to return the file object andmake sure that write is assigned to it. Then we call write with the fake html 
	  # file received write with the HTML
	  chart.create_to_file(file_path, measurements)
     #
	end
  end

