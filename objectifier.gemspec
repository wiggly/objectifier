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

  spec.required_ruby_version = '>= 1.9.3'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake"

  # NB: we require this so that guard does not require a higher version since higher
  # versions require ruby_dep which requires ruby 2.2.x as a runtime dependency...
  spec.add_development_dependency "listen", "~> 2.7.0"

  # NB: we require this so that simplecov doesn't pull in json 2.x since that requires ruby 2.x.x
  spec.add_development_dependency "json", "~> 1.0"

  spec.add_development_dependency "guard", "~> 2.0"
  spec.add_development_dependency "rspec", "~> 3.0"
  spec.add_development_dependency "guard-rspec", "~> 4.0"
  spec.add_development_dependency "simplecov", "~> 0.0"
end
