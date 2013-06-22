class FlexYear
  class CircaParser < RangeParser
    CIRCA_KEYWORDS = ["circ", "ca", "c.a.", "ca.", "cca", "c.", "approx", "appx", "about", "around"]

    def self.can_parse?(string)
      CIRCA_KEYWORDS.any?{|circa_pattern| string.downcase.include?(circa_pattern)}
    end

    def initialize(string)
      @string = string
    end

    def parse
      [-1, 1]
    end
  end
end
