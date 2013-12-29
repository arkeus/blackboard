require 'test_helper'

class DayTest < ActiveSupport::TestCase
  test "time to day identifier" do
  	assert_equal "aaa", Day.from_string("2013-01-01").identifier
  	assert_equal "baa", Day.from_string("2014-01-01").identifier
  	assert_equal "aba", Day.from_string("2013-02-01").identifier
  	assert_equal "aab", Day.from_string("2013-01-02").identifier
  	assert_equal "efj", Day.from_string("2017-06-10").identifier
  	assert_equal "elz", Day.from_string("2017-12-26").identifier
  	assert_equal "el0", Day.from_string("2017-12-27").identifier
  	assert_equal "el4", Day.from_string("2017-12-31").identifier
  end
  
  test "time to day identifier by time" do
  	assert_equal "aaa", Day.from_time(Time.new(2013, 1, 1)).identifier
  	assert_equal "el4", Day.from_time(Time.new(2017, 12, 31)).identifier
  end
  
  test "identifier to day" do
  	day = Day.from_identifier("el4")
  	assert_equal 2017, day.year
  	assert_equal 12, day.month
  	assert_equal 31, day.day
  	
  	day = Day.from_identifier("aaa")
  	assert_equal 2013, day.year
  	assert_equal 1, day.month
  	assert_equal 1, day.day
  end
end
