require File.join(File.dirname(__FILE__), 'spec_helper')

describe TrazzlerApi::Trazzler do
  before(:each) do
    WebMock.allow_net_connect!
    @trazzler = TrazzlerApi::Trazzler.new
  end
  
  context 'get_trip' do
    it 'should require id or permalink' do
      lambda { @trazzler.get_trip }.should raise_error(ArgumentError)
    end
    
    it 'should find by permalink' do
      trip = @trazzler.get_trip(:permalink => 'lauderdale-by-the-sea-florida')
      trip.url.should == 'http://www.trazzler.com/trips/lauderdale-by-the-sea-florida'
    end
    
    it 'should find by id' do
      trip = @trazzler.get_trip(:id => 4)
      trip.url.should == 'http://www.trazzler.com/trips/caribbean-island-of-anguilla'
    end
  end
  
  context 'trips' do
    it 'should default options as appropriate' do
      @trazzler.trips.page.should == 1
    end

    it 'should respect page option' do
      @trazzler.trips(:page => 2).page.should == 2
    end
  end
  
  context 'trips by location' do
    it 'should default options as appropriate' do
      @trazzler.trips_by_location.page.should == 1
    end

    it 'should respect location option' do
      @trazzler.trips_by_location(:location => '39.85,-86.03').location.should_not be_nil
    end

    it 'should respect page option' do
      @trazzler.trips_by_location(:page => 2).page.should == 2
    end
  end
  
  context 'units' do
    before(:each) do
      WebMock.disable_net_connect!
      @location = "San Francisco, CA"
      @url = "api.trazzler.com/units.json?q=#{@location}&unit_count=3"
    end
    
    it 'should fetch units for the specified location' do
      stub_request(:get, @url)
      @trazzler.units(@location)
      WebMock.should have_requested(:get, @url)
    end
    
    it 'should default to three units' do
      file = File.new(File.join(File.dirname(__FILE__), 'units_output.txt'))
      stub_request(:get, @url).to_return(:body => file, :status => 200)
      units = @trazzler.units(@location)
      units.should have(3).units
      units.each do |unit|
        unit.deal.should be
        unit.trips.should have(3).trips
      end
    end
    
    it 'should allow a different number of units to be specified' do
      count = 1
      @url = "api.trazzler.com/units.json?q=#{@location}&unit_count=1"
      stub_request(:get, @url)
      @trazzler.units(@location, count)
      WebMock.should have_requested(:get, @url)
    end
    
    it 'should be aliased as packages' do
      stub_request(:get, @url)
      @trazzler.packages(@location)
      WebMock.should have_requested(:get, @url)
    end
  end
  
  context 'promo unit' do
    before(:each) do
      WebMock.disable_net_connect!
      @deal_id = '123'
      @trip_ids = ['1', '2', '3']
      @url = "api.trazzler.com/units/promo.json?deal_id=123&featured_trips=1,2,3"
    end
    
    it 'should fetch a promo unit if given appropriate values' do
      stub_request(:get, @url)
      @trazzler.get_unit(@deal_id, @trip_ids)
      WebMock.should have_requested(:get, @url)
    end
    
    it 'should be aliased as get_package' do
      stub_request(:get, @url)
      @trazzler.get_package(@deal_id, @trip_ids)
      WebMock.should have_requested(:get, @url)
    end
    
    it 'should return appropriate deal fields' do
      file = File.new(File.join(File.dirname(__FILE__), 'promo_output.txt'))
      stub_request(:get, @url).to_return(:body => file, :status => 200)
      unit = @trazzler.get_unit(@deal_id, @trip_ids)
      unit.deal.should be
      deal = unit.deal
      deal.display_name.should == "Courtyard Orlando Downtown"
      deal.price.should == 69
      deal.percent_savings.should == 68
      deal.city.should == "Orlando"
      deal.state.should == "FL"
      deal.cc.should == "US"
      deal.crc.should == "Orlando, FL"
      deal.url.should == "http://www.dealbase.com/hotel_deals/book/p/priceline.com/266330?rc=trazzler"
      deal.deal_start.should == "2010/10/22"
      deal.deal_end.should == "2010/10/24"
      deal.stale.should be_false
      deal.phone.should be_nil
      deal.weekend_available.should be_false
      deal.id.should == "4cba4eed682cea5462000258"
      deal.latlng.should == [28.5383355,-81.3792365]
    end
    
    context 'with deals as array' do
      it 'should retrieve and parse the JSON results for a promo unit' do
        file = File.new(File.join(File.dirname(__FILE__), 'promo_deals_array_output.txt'))
        stub_request(:get, @url).to_return(:body => file, :status => 200)
        unit = @trazzler.get_unit(@deal_id, @trip_ids)
        unit.deal.should be
        unit.trips.should have(3).trips
      end
    end
    
    context 'with singular deal' do
      it 'should retrieve and parse the JSON results for a promo unit' do
        file = File.new(File.join(File.dirname(__FILE__), 'promo_output.txt'))
        stub_request(:get, @url).to_return(:body => file, :status => 200)
        unit = @trazzler.get_unit(@deal_id, @trip_ids)
        unit.deal.should be
        unit.trips.should have(3).trips
      end
    end
  end
end