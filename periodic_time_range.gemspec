# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'periodic_time_range/version'

Gem::Specification.new do |spec|
  spec.name          = 'periodic_time_range'
  spec.version       = PeriodicTimeRange::VERSION
  spec.authors       = ['Jared Beck']
  spec.email         = ['jared@jaredbeck.com']
  spec.summary       = %q{Recurring, sequential ranges of time}
  spec.description   = %q{No description}
  spec.homepage      = ''
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'activesupport', '~> 4.1'
  spec.add_development_dependency 'bundler', '<= 1.7'
  spec.add_development_dependency 'rspec', '~> 3.0'
end
