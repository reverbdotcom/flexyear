class FlexYear
  class AsteriskParser < RangeParser
    def self.can_parse?(string)
      string.end_with?('*')
    end

    def parse
      [0, 9]
    end
  end
end
