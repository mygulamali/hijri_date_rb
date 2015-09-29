# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'hijri_date/version'

Gem::Specification.new do |spec|
  spec.name          = 'hijri_date'
  spec.version       = HijriDate::VERSION
  spec.authors       = ['Murtaza Gulamali']
  spec.email         = ['mygulamali@gmail.com']
  spec.description   = 'Manage Islamic Hijri dates.'
  spec.summary       = 'Hijri date object'
  spec.homepage      = 'https://github.com/mygulamali/hijri_date'
  spec.license       = 'MIT'

  spec.files         = `git ls-files`.split($INPUT_RECORD_SEPARATOR)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ['lib']

  spec.add_development_dependency 'bundler', '~> 1.10'
  spec.add_development_dependency 'minitest', '~> 5.8'
  spec.add_development_dependency 'rake', '~> 10.4'
  spec.add_development_dependency 'rubocop', '~> 0.34'
end
