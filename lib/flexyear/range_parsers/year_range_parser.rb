class FlexYear
  class YearRangeParser < RangeParser
    def self.can_parse?(string)
      string.include?('-') && string =~ /(\d+)\s*-\s*(\d+)/
    end

    # Nothing to do here, see FlexYear#parse_year
    def parse; end
  end
end
