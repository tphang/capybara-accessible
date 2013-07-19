# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'capybara/accessible/version'

Gem::Specification.new do |spec|
  spec.name          = "capybara-accessible"
  spec.version       = Capybara::Accessible::VERSION
  spec.authors       = ["Case Commons"]
  spec.email         = ["accessibility@casecommons.org"]
  spec.description   = %q{Capybara extension and webdriver for automated accessibility testing}
  spec.summary       = %q{A Selenium based webdriver and Capybara extension that runs Google Accessibility Developer Tools auditing assertions on page visits.}
  spec.homepage      = "https://github.com/Casecommons/capybara-accessible"
  spec.license       = "MIT"

  spec.files         = `git ls-files`.split($/)

  # Taken from http://somethingaboutcode.wordpress.com/2012/09/27/include-files-from-git-submodules-when-building-a-ruby-gem/
  gem_dir = File.expand_path(File.dirname(__FILE__)) + "/"
  `git submodule --quiet foreach pwd`.split($\).each do |submodule_path|
    Dir.chdir(submodule_path) do
      submodule_relative_path = submodule_path.sub gem_dir, ""
      # issue git ls-files in submodule's directory and
      # prepend the submodule path to create absolute file paths
      `git ls-files`.split($\).each do |filename|
        spec.files << "#{submodule_relative_path}/#{filename}"
      end
    end
  end

  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency("capybara")
  spec.add_dependency("selenium-webdriver")
  
  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "pry"
  spec.add_development_dependency "tddium"

  # Sinatra is used by Capybara's TestApp
  spec.add_development_dependency("sinatra")
end
