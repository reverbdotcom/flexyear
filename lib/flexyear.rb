require 'flexyear/range_parsers/range_parser'
require 'flexyear/range_parsers/asterisk_parser'
require 'flexyear/range_parsers/early_parser'
require 'flexyear/range_parsers/mid_parser'
require 'flexyear/range_parsers/late_parser'
require 'flexyear/range_parsers/after_parser'
require 'flexyear/range_parsers/before_parser'
require 'flexyear/range_parsers/decade_parser'
require 'flexyear/range_parsers/year_range_parser'
require 'flexyear/range_parsers/circa_parser'
require 'flexyear/range_parsers/specific_year_parser'
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

  attr_reader :year_low, :year_high, :decade, :decades

  def initialize(year_input)
    @year_input = year_input

    if year_input.is_a?(Array)
      parse_year_list(year_input)
    else
      parse_year_string(year_input)
    end
  end

  def to_s
    @year_input
  end

  def decade?
    return false unless year_low && year_high
    year_low % 10 == 0 && year_high % 10 == 9
  end

  def parse_decade(yr_low, yr_high)
    return if @year_input.is_a?(Array)
    return unless yr_low && yr_high

    same_decade = yr_low.to_s[0,3] == yr_high.to_s[0, 3]
    @decade = "#{yr_low.to_s[0,3]}0s" if same_decade
  end

  def parse_decades(years)
    return unless @year_input.is_a?(Array)

    parsed_decades = years.flat_map { |y| self.class.new(y).decade }
    @decades = parsed_decades
  end

  private

  def parse_year_list(years)
    all_years = years.flat_map do |y|
      year = self.class.new(y)
      [year.year_low, year.year_high]
    end

    flat_years = all_years.uniq.map { |y| y.nil? ? Date.today.year : y }

    @year_low = flat_years.min
    @year_high = flat_years.max

    parse_decades(years)
  end

  def parse_year_string(year_string)
    parse_year(year_string.to_s.strip)
    parse_decade(@year_low, @year_high)
  end

  def centuryize(year, base_year=nil)
    base = default_base_year(year)
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

  def default_base_year(year)
    current_year = Date.today.year.to_s
    if year.to_i < current_year[-2..-1].to_i
      "20" # 21st century
    else
      "19" # 20th century
    end
  end

  def parse_year(year_string)
    low, high = RangeParser.parse(year_string)

    if year_string =~ range_regex && $1 && $2
      @year_low = centuryize($1).to_i
      @year_low, @year_high = [@year_low, centuryize($2, @year_low).to_i].sort
    elsif year_string =~ open_ended_range_regex
      @year_low = centuryize($1).to_i
      @year_high = Date.today.year
    else
      if year_string =~ decade_regex
        @base_year = centuryize($1).to_i
      elsif year_string =~ asterisk_regex
        @base_year = centuryize($1).to_i * 10
      elsif year_string =~ starts_with_word_regex
        @base_year = centuryize($1).to_i
      else
        @base_year = centuryize(year_string.gsub(/\D+/,'')).to_i
      end

      if @base_year > 9999
        raise InvalidYearError, "Please use a four digit year."
      end

      @year_low = @base_year + low unless low.nil?
      @year_high = @base_year + high unless high.nil?
    end
  end

  def range_regex
    /(\d+)\s*-\s*(\d+)/
  end

  def open_ended_range_regex
    /(\d+)\s*-\s*(\D+)/
  end

  def asterisk_regex
    /(\d+).*\*$/
  end

  def decade_regex
    /(\d+).*s$/
  end

  def starts_with_word_regex
    /^\w+\s+(\d+)/
  end

  # Represents a flexible year entry that must be in the past.
  class Historical < FlexYear
    private

    def parse_year(year_string)
      super(year_string)

      if (!@year_low.nil? && @year_low > DateTime.now.year) || (!@year_high.nil? && @year_high > DateTime.now.year)
        raise InvalidYearError, "The year must be in the past. You specified #{year_string}; Today is #{DateTime.now.year}"
      end
    end
  end
end
