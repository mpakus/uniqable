
# frozen_string_literal: true

lib = File.expand_path('lib', __dir__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'uniqable/version'

Gem::Specification.new do |spec|
  spec.name          = 'uniqable'
  spec.version       = Uniqable::VERSION
  spec.authors       = ['Renat "MpaK" Ibragimov']
  spec.email         = ['mrak69@gmail.com']

  spec.summary       = 'Uniqable - uniq and random token for ActiveRecord models'
  spec.description   = 'Generate a unique, random token for ActiveRecord models.'
  spec.homepage      = 'https://github.com/mpakus/uniqable'

  spec.files = Dir.chdir(File.expand_path(__dir__)) do
    `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_development_dependency 'activerecord', '~> 4.1.14.1'
  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rspec', '~> 3.0'
  spec.add_development_dependency 'rubocop', '~> 0.49'
end
