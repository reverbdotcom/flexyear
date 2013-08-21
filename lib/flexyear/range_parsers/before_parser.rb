class FlexYear
  class BeforeParser < RangeParser
    def self.can_parse?(string)
      string.start_with?('before')
    end

    def parse
      [nil, 0]
    end
  end
end
