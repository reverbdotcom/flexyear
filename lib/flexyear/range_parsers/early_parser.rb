class FlexYear
  class EarlyParser < RangeParser
    def self.can_parse?(string)
      string.start_with?('early')
    end

    def parse
      [0, 3]
    end
  end
end
