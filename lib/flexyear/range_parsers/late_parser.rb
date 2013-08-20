class FlexYear
  class LateParser < RangeParser
    def self.can_parse?(string)
      string.start_with?('late')
    end

    def parse
      [6, 9]
    end
  end
end
