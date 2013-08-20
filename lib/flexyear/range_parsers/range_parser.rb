class FlexYear
  class RangeParser
    class << self
      attr_reader :parser_classes
    end

    @parser_classes = []

    def self.parse(string)
      parser = find_parser(string)
      return nil unless parser
      parser.parse
    end

    def self.find_parser(string)
      parser_class = RangeParser.parser_classes.find do |klass|
        klass.can_parse?(string)
      end
      return parser_class.new(string) if parser_class
      nil
    end

    def self.inherited(subclass)
      RangeParser.parser_classes << subclass
    end

    def initialize(string)
      @string = string
    end
  end
end
