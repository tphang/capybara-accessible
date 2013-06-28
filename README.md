# Capybara::Accessible

Automated accessibility testing for Rails integration tests (Rspec + Capybara)
capybara-accessible automatically runs [Google's Accessibility Developer Tools](https://code.google.com/p/accessibility-developer-tools/) audits within your Ruby on Rails project integration test suite, using [RSpec feature specs](https://www.relishapp.com/rspec/rspec-rails/docs/feature-specs/feature-spec).

Some of the checks that are included:
* minimum color contrast
* label associations with inputs
* presence of alt attributes
* valid use of ARIA roles

The full list of accessibility audit rules is on the [Google Accessibility Developer Tools wiki](https://code.google.com/p/accessibility-developer-tools/wiki/AuditRules).

capybara-accessible extends Capybara and defines a custom webdriver that runs javascript assertions on every page visit and link/button click.
This way you do not need to make explicit assertions on accessibility. Instead, the test will simply fail with a message indicating the accessibility errors, like so:

    Failure/Error: @session.visit('/inaccessible')
    Capybara::Accessible::InaccessibleError:

      <input> tag with text "foo" - Controls and media elements should have labels

Need help? Ask on the mailing list (please do not open an issue on GitHub): https://groups.google.com/forum/#!forum/capybara-accessible

## Installation

Add this line to your application's Gemfile:

    gem 'capybara-accessible'

And then execute:

    $ bundle

Or install it yourself as:

    $ gem install capybara-accessible

## Usage

You can use capybara-accessible as a drop-in replacement for Rack::Test, Selenium or capybara-webkit drivers for Capybara. Simply set the driver in spec_helper.rb:

    require 'capybara/rspec'
    require 'capybara/accessible'

    Capybara.current_driver = :accessible

You can also optionally exclude individual accessibility assertions from being run:

    Capybara::Accessible::Auditor.exclusions = ['AX_FOCUS_01', 'AX_TEXT_01']

You can use exclusions to supress failures for accessibility errors that you cannot immediately address, without turning off all assertions.

See the [Google Accessibility Developer Tools wiki](https://code.google.com/p/accessibility-developer-tools/wiki/AuditRules) for the complete list of codes.

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
