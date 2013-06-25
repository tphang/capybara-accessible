# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capybara/accessible/version'

Gem::Specification.new do |spec|
  spec.name          = "capybara-accessible"
  spec.version       = Capybara::Accessible::VERSION
  spec.authors       = ["Casebook"]
  spec.email         = ["casebook-dev@googlegroups.com"]
  spec.description   = %q{Driver that extends Selenium to run accessibility tests}
  spec.summary       = %q{Driver that extends Selenium to run accessibility tests}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_runtime_dependency("capybara", "~> 2.0", ">= 2.0.2")
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"

  # Sinatra is used by Capybara's TestApp
  spec.add_development_dependency("sinatra")
  spec.add_development_dependency("selenium-webdriver")
end
