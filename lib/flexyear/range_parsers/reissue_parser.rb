class FlexYear
  class ReissueParser < RangeParser
    def self.can_parse?(string)
      string.downcase.include?('reissue')
    end

    def initialize(string)
      @string = string
    end

    def parse
      raise InvalidYearError, 'Please enter the date of manufacture, not the reissue era.'
    end
  end
end
