class FlexYear
  class AfterParser < RangeParser
    def self.can_parse?(string)
      string.start_with?('after')
    end

    def initialize(string)
      @string = string
    end

    def parse
      [0, Float::INFINITY]
    end
  end
end
