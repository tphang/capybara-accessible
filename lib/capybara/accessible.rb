require 'capybara'
require 'capybara/accessible/auditor'
require 'capybara/accessible/element'
require "capybara/accessible/version"
require 'capybara/webkit'

module Capybara
  module Accessible
  end
end

# require "capybara/accessible/driver"
require "capybara/accessible/driver_webkit"

# Capybara.register_driver :accessible do |app|
  # Capybara::Accessible::Driver.new(app)
# end

Capybara.register_driver :accessible_webkit do |app|
  Capybara::Accessible::DriverWebkit.new(app)
end
