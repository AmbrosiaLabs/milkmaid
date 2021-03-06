# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'milk_maid/version'

Gem::Specification.new do |spec|
  spec.name          = "milk_maid"
  spec.version       = MilkMaid::VERSION
  spec.authors       = ["Steve Newell"]
  spec.email         = ["steve.newell@mx.com"]

  spec.summary       = %q{Reads data from Raspberry PI sensor and posts to Firebase}
  spec.description   = %q{Reads data from Raspberry PI sensor and posts to Firebase}

  # Prevent pushing this gem to RubyGems.org by setting 'allowed_push_host', or
  # delete this section to allow pushing this gem to any host.
  if spec.respond_to?(:metadata)
    spec.metadata['allowed_push_host'] = "https://rubygems.org"
  else
    raise "RubyGems 2.0 or newer is required to protect against public gem pushes."
  end

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "bin"
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "thor"
  spec.add_runtime_dependency "w1temp"
  spec.add_runtime_dependency "parse-ruby-client"
  spec.add_runtime_dependency "firebase"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "guard-rspec"
end
