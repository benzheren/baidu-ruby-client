# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'baidu/version'

Gem::Specification.new do |spec|
  spec.name          = "baidu-ruby-client"
  spec.version       = Baidu::VERSION
  spec.authors       = ["Ben Hu"]
  spec.email         = ["benzheren@gmail.com"]
  spec.description   = "A Ruby Client for Baidu Developer REST APIs"
  spec.summary       = "A Ruby Client for Baidu Developer REST APIs"
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_dependency "patron", ">= 0"
end
