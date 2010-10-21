require File.join(File.dirname(__FILE__), 'spec_helper')

describe TrazzlerApi::Trazzler do
  before(:each) do
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
end