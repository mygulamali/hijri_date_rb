require 'hijri_date/version'
require 'hijri_date/month_names'
require 'hijri_date/constants'

module HijriDate
  class Date
    # create setters and getters
    attr_accessor :year, :month, :day

    # constructor
    def initialize(year = 1432, month = 4 , day = 20)
      @year = year
      @month = month
      @day = day
    end

    # convert to string object
    def to_s(date = self)
      "#{date.day} #{HijriDate::MONTHNAMES_EN[date.month]} #{date.year}H"
    end

    # is this (or the specified) year a Kabisa year?
    def is_kabisa?(year = self.year)
      for i in [2, 5, 8, 10, 13, 16, 19, 21, 24, 27, 29]
        if year % 30 == i
          return true
        end
      end
      false
    end

    # number of days in this (or the specified) month and year
    def days_in_month(month = self.month, year = self.year)
      if month == 12 && is_kabisa?(year) || month % 2 == 1
        return 30
      end
      29
    end

    # day of the year corresponding to this (or specified) Hijri date
    def day_of_year(date = self)
      if date.month == 1
        return date.day
      end
      HijriDate::DAYSINYEAR[date.month - 2] + date.day
    end

    # return Julian Day number associated with this (or specified) Hijri date
    def jd(date = self)
      y30 = (date.year / 30.0).floor
      if (date.year % 30 == 0)
        return 1948084 + y30 * 10631 + day_of_year(date)
      else
        return 1948084 + y30 * 10631 + HijriDate::DAYSIN30YEARS[date.year - y30 * 30 - 1] + day_of_year(date)
      end
    end

    # comparison operator
    def == (date)
      if date.is_a?(HijriDate::Date)
        if date.year == year && date.month == month && date.day == day
          return true
        end
        return false
      end
      raise TypeError, 'expected HijriDate::Date'
    end

    # return a new HijriDate object that is n days after the current one.
    def + (n)
      case n
      when Numeric; return HijriDate.jd(jd + n)
      end
      raise TypeError, 'expected numeric'
    end

    # return a new HijriDate object that is n days before the current one.
    def - (n)
      case n
      when Numeric; return HijriDate.jd(jd - n)
      end
      raise TypeError, 'expected numeric'
    end

    # return the day of the week (0-6, Sunday is zero)
    def wday
      Object::Date.jd(jd).wday
    end
  end

  # return new Hijri Date object associated with specified Julian Day number
  def HijriDate.jd(jd = 1948084)
    left = (jd - 1948084).to_i
    y30 = (left / 10631.0).floor
    left -= y30 * 10631
    i = 0

    while left > HijriDate::DAYSIN30YEARS[i]
      i += 1
    end
    year = (y30 * 30.0 + i).to_i

    if i > 0
      left -= HijriDate::DAYSIN30YEARS[i - 1]
    end
    i = 0

    while left > HijriDate::DAYSINYEAR[i]
      i += 1
    end
    month = (i + 1).to_i

    if i > 0
      day = (left - HijriDate::DAYSINYEAR[i - 1]).to_i
    else
      day = left.to_i
    end

    HijriDate::Date.new(year, month, day)
  end
end
