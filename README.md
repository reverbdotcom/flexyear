# Flexyear

Flexible years! Parse decades, ranges, and etc into low & high values.

Examples:

```ruby
FlexYear.new("1980s").year_low == 1980
FlexYear.new("1980s").year_high == 1989

FlexYear.new("mid-80s").year_low == 1983
FlexYear.new("mid-80s").year_high == 1986
```

It's pretty flexible in the kinds of things it takes. For more examples, see the spec.

## Installation

Add this line to your application's Gemfile:

```ruby
gem 'flexyear'
```

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install flexyear

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
