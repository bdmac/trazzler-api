require File.join(File.dirname(__FILE__), 'test_helper')

class ApiTest < Test::Unit::TestCase
  context 'get_trip' do
    
    should 'require id or permalink' do
      assert_raise ArgumentError do
        Trazzler.get_trip
      end
    end
    
    should 'find by permalink' do
      trip = Trazzler.get_trip(:permalink => 'lauderdale-by-the-sea-florida')
      assert_equal 'http://www.trazzler.com/trips/lauderdale-by-the-sea-florida', trip.url
    end
    
    should 'find by id' do
      trip = Trazzler.get_trip(:id => 4)
      assert_equal 'http://www.trazzler.com/trips/caribbean-island-of-anguilla', trip.url
    end
    
  end
  
  context 'trip stack' do
    
    should 'default options as appropriate' do
      stack = Trazzler.trip_stack
      assert_equal '1', stack.current_page
      assert_nil stack.location
    end
    
    should 'respect location option' do
      stack = Trazzler.trip_stack(:location => '39.85,-86.03')
      assert_not_nil stack.location
    end
    
    should 'respect page option' do
      stack = Trazzler.trip_stack(:page => 2)
      assert_equal '2', stack.current_page
    end
    
  end
  
end