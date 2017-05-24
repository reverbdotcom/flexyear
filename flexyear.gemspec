# coding: utf-8
lib = File.expand_path("../lib", __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require "flexyear/version"

Gem::Specification.new do |spec|
  spec.name          = "flexyear"
  spec.version       = FlexYear::VERSION
  spec.authors       = ["Dan Melnick & Yan Pritzker"]
  spec.email         = ["pair+dm+yp@reverb.com"]
  spec.description   = "Parse common year range formats like '1973-75' or natural language ranges like 'mid 80s'"
  spec.summary       = "Natural language year range parser"
  spec.homepage      = "http://github.com/reverbdotcom/flexyear"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec", "~> 3.5"
  spec.add_development_dependency "rspec-its", "~> 1.2"
end
