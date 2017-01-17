require "rspec"
require "rspec/its"
require "yaml"
require 'flexyear'

def text_examples
  YAML.load_file("#{File.dirname(__FILE__)}/fixtures/flexyear.yml")
end

describe FlexYear do
  before do
    allow(Date).to receive(:today) { Date.parse("2016-11-07") }
  end

  [FlexYear, FlexYear::Historical].each do |flexyear_class|
    describe "#{flexyear_class.name}" do
      text_examples.each do |ex|
        [ex["input"]].flatten.each do |input|
          it "should return #{ex["year_low"].inspect},#{ex["year_high"].inspect} when given #{input.inspect}" do
            result = flexyear_class.new(input)
            expect(result.year_low).to eq(ex["year_low"])
            expect(result.year_high).to eq(ex["year_high"])
          end
        end
      end
    end

    context "given 12345 (five digit year)" do
      specify do
        expect { flexyear_class.new('12345') }.to raise_error(FlexYear::InvalidYearError)
      end
    end
  end

  describe FlexYear::Historical do
    context "given a year past today" do
      specify do
        expect { FlexYear::Historical.new('3000') }.to raise_error(FlexYear::InvalidYearError)
      end
    end
  end

end
