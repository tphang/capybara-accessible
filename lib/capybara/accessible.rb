require 'capybara'
require 'capybara/webkit'
require 'capybara/accessible/auditor'
require 'capybara/accessible/element'
require "capybara/accessible/version"

module Capybara
  module Accessible
  end
end

require "capybara/accessible/driver"
require "capybara/accessible/webkit_driver"

Capybara.register_driver :accessible do |app|
  Capybara::Accessible::Driver.new(app)
end

Capybara.register_driver :accessible_webkit do |app|
  Capybara::Accessible::WebkitDriver.new(app)
end
