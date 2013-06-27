# Capybara::Accessible

capybara-accessible automatically runs [Google's Accessibility Developer Tools](https://code.google.com/p/accessibility-developer-tools/) audits within your Ruby on Rails project integration test suite, using [RSpec feature specs](https://www.relishapp.com/rspec/rspec-rails/docs/feature-specs/feature-spec).

It does this by extending Capybara and defining a custom webdriver that runs javascript assertions on every page visit and link/button click.
This way you do not need to make explicit assertions on accessibility. Instead, the test will simply fail with a message indicating the accessibility errors.

You can use capybara-accessible as a drop-in replacement for Rack::Test, Selenium or capybara-webkit drivers.

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

    Capybara::Accessible::Auditor.exclusions = ['AX_FOCUS_01', 'AX_TEXT_01']

You can use exclusions to supress failures for accessibility errors that you cannot immediately address, without turning off all assertions.

The full list of accessibility audit rules is on the [Google Accessibility Developer Tools wiki](https://code.google.com/p/accessibility-developer-tools/wiki/AuditRules).

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
