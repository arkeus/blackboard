require 'test_helper'

class MonthTest < ActiveSupport::TestCase
  test "cover 30 day month" do
  	november = Time.new.change(month: 11)
  	month = Month.new(november)
  	count = 0
  	month.each_day { |day| count += 1 }
  	assert_equal 30, count
  end
  
  test "cover 31 day month" do
  	december = Time.new.change(month: 12)
  	month = Month.new(december)
  	count = 0
  	month.each_day { |day| count += 1 }
  	assert_equal 31, count
  end
end
