class FlexYear
  class DecadeParser < RangeParser
    def self.can_parse?(string)
      string.end_with?('s')
    end

    def initialize(string)
      @string = string
    end

    def parse
      [0, 9]
    end
  end
end
