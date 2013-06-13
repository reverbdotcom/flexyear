require 'flexyear/version'
require 'date'

# Represents a flexible year entry:
#
#  * 1979 - a specific year
#  * 1970s and 70s - decades
#  * mid-70s, early-70s, late-70s - subdecades, dashes optional
#  * 1972-1975 - a range
#
# All years can be in two or four digit format
class FlexYear
  class InvalidYearError < ArgumentError; end

  attr_reader :year_low, :year_high

  CIRCA_KEYWORDS = ["circ", "ca", "c.a.", "ca.", "cca", "c.", "approx", "appx", "about", "around"]

  def initialize(year_string)
    @year_string = year_string.to_s

    if @year_string.start_with?("early")
      @low = 0
      @high = 3
    elsif @year_string.start_with?("mid")
      @low = 3
      @high = 6
    elsif @year_string.start_with?("late")
      @low = 6
      @high = 9
    elsif @year_string.end_with?("s") # decade
      @low = 0
      @high = 9
    elsif @year_string.include?("-")
      @year_string =~ /(\d+)\s*-\s*(\d+)/
      if $1 && $2
        @year_low = centuryize($1).to_i
        @year_high = centuryize($2, @year_low).to_i
        return
      end
    elsif CIRCA_KEYWORDS.any?{|circa_pattern| @year_string.downcase.include?(circa_pattern)}
      @low  = -1
      @high = 1
    elsif @year_string.downcase.include?('reissue')
      raise InvalidYearError, 'Please enter the date of manufacture, not the reissue era.'
    else # specific year
      @low = 0
      @high = 0
    end

    parse_year
  end

  def to_s
    @year_string
  end

  private

  def centuryize(year, base_year=nil)
    base = "19" # 19th century
    if base_year
      base = (base_year/100).to_s
    end

    if year.length == 1
      "#{base}0#{year}"
    elsif year.length == 2
      "#{base}#{year}"
    else
      year
    end
  end

  def parse_year
    if @year_string =~ /(\d+).*s$/
      @base_year = centuryize($1).to_i
    elsif @year_string =~ /^\w+\s+(\d+)/
      @base_year = centuryize($1).to_i
    else
      @base_year = @year_string.gsub(/\D+/,'').to_i
    end

    if @base_year > 9999
      raise InvalidYearError, "Please use a four digit year."
    end

    @year_low = @base_year + (@low || -1)
    @year_high = @base_year + (@high || 1)
  end

  # Represents a flexible year entry that must be in the past.
  class Historical < FlexYear
    private

    def parse_year
      super

      if @base_year > DateTime.now.year
        raise InvalidYearError, "The year must be in the past. You specified #{@base_year}; Today is #{DateTime.now.year}"
      end
    end
  end
end
