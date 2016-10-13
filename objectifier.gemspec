# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'objectifier/version'

Gem::Specification.new do |spec|
  spec.name          = "objectifier"
  spec.version       = Objectifier::VERSION
  spec.authors       = ["Nigel Rantor"]
  spec.email         = ["wiggly@wiggly.org"]

  spec.summary       = %q{De-serialize plain hashes into real object graphs}
  spec.description   = %q{Customize how you de-serialise hashes into real objects.}
  spec.homepage      = "http://github.com/wiggly/objectifier"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "guard-rspec"
  spec.add_development_dependency "simplecov"
end
