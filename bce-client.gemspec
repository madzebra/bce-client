# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'bce_client/version'

Gem::Specification.new do |spec|
  spec.name          = 'bce-client'
  spec.version       = BceClient::VERSION
  spec.summary       = 'Block Chain Explorer Client for altcoins.'
  spec.description   = <<-EOF
     Block Chain Explorer Client for altcoins.
     Extracted from BCE project.
    EOF

  spec.author        = 'Mad Zebra'
  spec.email         = 'dunno'
  spec.homepage      = 'https://github.com/madzebra/'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0")
  spec.test_files    = spec.files.grep(/spec/)
  spec.require_paths = ['lib']

  spec.required_ruby_version = '>= 2.1'
  spec.add_runtime_dependency 'bundler', '~> 1.7'
  spec.add_runtime_dependency 'rake', '~> 10.0'
  spec.add_runtime_dependency 'json', '~> 1.8'

  spec.add_development_dependency 'rspec', '~> 3.2'
  spec.add_development_dependency 'webmock', '~> 1.20'
end
