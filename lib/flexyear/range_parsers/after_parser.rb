class FlexYear
  class AfterParser < RangeParser
    def self.can_parse?(string)
      string.start_with?('after')
    end

    def parse
      [0, nil]
    end
  end
end
