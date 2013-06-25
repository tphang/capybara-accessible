require 'rspec'
require 'rspec/autorun'
require 'rbconfig'
require 'capybara'
require 'capybara/spec/spec_helper'
require 'capybara/accessible'
require 'accessible_app'
require 'pry'

PROJECT_ROOT = File.expand_path(File.join(File.dirname(__FILE__), '..')).freeze
$LOAD_PATH << File.join(PROJECT_ROOT, 'lib')

RSpec.configure do |c|
  Capybara::SpecHelper.configure(c)
end

Capybara.current_driver = :accessible
