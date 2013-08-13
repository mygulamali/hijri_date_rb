require 'date'
require 'hijri_date'
require 'minitest/autorun'
require 'minitest/pride'

class HijriDateTest < MiniTest::Unit::TestCase
  def setup
    @date = HijriDate::Date.new  # 20/04/1432H = 25/03/2011AD
    @jd = Date.new(2011, 3, 25).jd
    @ajd = @jd - 0.5
  end

  def test_kabisa_year
    refute @date.is_kabisa?
    assert @date.is_kabisa? 1431
  end

  def test_days_in_month
    assert_equal 29, @date.days_in_month
    assert_equal 29, @date.days_in_month(12)
    assert_equal 30, @date.days_in_month(12, 1431)
  end

  def test_day_of_year
    assert_equal 109, @date.day_of_year
    assert_equal  10, @date.day_of_year(HijriDate::Date.new(1432, 1, 10))
    assert_equal 355, @date.day_of_year(HijriDate::Date.new(1431, 12, 30))
    assert_equal 354, @date.day_of_year(HijriDate::Date.new(1432, 12, 29))
  end

  def test_jd
    assert_equal @jd, @date.jd
  end

  def test_ajd
    assert_equal @ajd, @date.ajd
  end

  def test_comparison
    date = HijriDate::Date.new(@date.year, @date.month, @date.day)
    assert @date == date
  end

  def test_add
    assert_equal 21, (@date + 1).day

    date = HijriDate::Date.new(1432, 12, 29) + 1
    assert_equal HijriDate::Date.new(1433, 1, 1), date
  end

  def test_subtract
    assert_equal 19, (@date - 1).day

    date = HijriDate::Date.new(1433, 1, 1) - 1
    assert_equal HijriDate::Date.new(1432, 12, 29), date
  end

  def test_jd!
    assert_equal @date, HijriDate.jd!(@jd)
  end

  def test_from_ajd
    assert_equal @date, HijriDate.from_ajd(@ajd)
  end
end
