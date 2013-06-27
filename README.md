# Capybara::Accessible

Defines a web driver and extends Capybara to assert accessibility on page visits in [RSpec feature specs](https://www.relishapp.com/rspec/rspec-rails/docs/feature-specs/feature-spec).

capybara-accessible uses [Google's Accessibility Developer Tools](https://code.google.com/p/accessibility-developer-tools/) assertions to performs automated accessibility audits.

Use capybara-accessible in place of the Selenium or capybara-webkit drivers to invoke these assertions on link clicks and page visits.

## Installation

Add this line to your application's Gemfile:

    gem 'capybara-accessible'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capybara-accessible

## Usage

Require and register the driver in spec_helper.rb:

    require 'capybara/rspec'
    require 'capybara/accessible'

    Capybara.current_driver = :accessible

Optionally exclude rules from being run:

    Capybara::Accessible::Auditor.exclusions = ['AX_FOCUS_01']

The full list of rules is on the [Google Accessibility Developer Tools wiki](https://code.google.com/p/accessibility-developer-tools/wiki/AuditRules).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
