class FlexYear
  class SpecificYearParser < RangeParser
    def self.can_parse?(string)
      string =~ /\A\d+\z/
    end

    def parse
      [0, 0]
    end
  end
end
