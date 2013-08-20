class FlexYear
  class MidParser < RangeParser
    def self.can_parse?(string)
      string.start_with?('mid')
    end

    def parse
      [3, 6]
    end
  end
end
