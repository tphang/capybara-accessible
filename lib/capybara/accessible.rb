require 'capybara'
require "capybara/accessible/version"

module Capybara
  module Accessible
  end
end

require "capybara/accessible/driver"

Capybara.register_driver :accessible do |app|
  Capybara::Accessible::Driver.new(app)
end
