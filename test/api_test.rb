require File.join(File.dirname(__FILE__), 'test_helper')

class ApiTest < Test::Unit::TestCase
  def setup
    @trazzler = Trazzler.new
  end

  context 'get_trip' do

    should 'require id or permalink' do
      assert_raise ArgumentError do
        @trazzler.get_trip
      end
    end

    should 'find by permalink' do
      trip = @trazzler.get_trip(:permalink => 'lauderdale-by-the-sea-florida')
      assert_equal 'http://www.trazzler.com/trips/lauderdale-by-the-sea-florida', trip.url
    end

    should 'find by id' do
      trip = @trazzler.get_trip(:id => 4)
      assert_equal 'http://www.trazzler.com/trips/caribbean-island-of-anguilla', trip.url
    end

  end

  context 'trips' do

    should 'default options as appropriate' do
      stack = @trazzler.trips
      assert_equal 1, stack.page
    end

    should 'respect page option' do
      stack = @trazzler.trips(:page => 2)
      assert_equal 2, stack.page
    end

  end

  context 'trips by location' do

    should 'default options as appropriate' do
      stack = @trazzler.trips_by_location
      assert_equal 1, stack.page
    end

    should 'respect location option' do
      stack = @trazzler.trips_by_location(:location => '39.85,-86.03')
      assert_not_nil stack.location
    end

    should 'respect page option' do
      stack = @trazzler.trips_by_location(:page => 2)
      assert_equal 2, stack.page
    end

  end

end
