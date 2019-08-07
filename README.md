# Flexyear

Flexible years! Parse decades, ranges, and etc into low & high values.

Examples:

```ruby
FlexYear.new("1980s").year_low == 1980
FlexYear.new("1980s").year_high == 1989
FlexYear.new("1980s").decade == 1980s

FlexYear.new("mid-80s").year_low == 1983
FlexYear.new("mid-80s").year_high == 1986
FlexYear.new("mid-80s").decade == 1980s

FlexYear.new(1983).year_low == 1983
FlexYear.new(1983).year_high == 1983
FlexYear.new(1983).decade == 1980s

FlexYear.new(198*).year_low == 1980
FlexYear.new(198*).year_high == 1989
FlexYear.new(198*).decade == 1980s

FlexYear.new(["1980s", "1988 - 2000", 2001]).year_low == 1980
FlexYear.new(["1980s", "1988 - 2000", 2001]).year_high == 2001
FlexYear.new(["1980s", "1988 - 2000", nil, 2001]).decades == [1980s, nil, nil, 2000s]
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

### Test

`rake`

### Publish a new version

We use bundlers rake commands to release versions. To cut and release a new version:

1. Update lib/flexyear/version.rb and increment to your new desired version
2. Commit and push your version bump
3. Run `bundle exec rake release` to package and publish that version
