# Capybara::Accessible

[![](https://api.tddium.com/pivotal-casebook/capybara-accessible/badges/25347.png?badge_token=1e276156136851abb3ca113d37e1cddca332e098)](https://api.tddium.com/pivotal-casebook/capybara-accessible/suites/25347)

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

    Failure/Error: visit '/inaccessible'
     Capybara::Accessible::InaccessibleError:
       *** Begin accessibility audit results ***
       An accessibility audit found
       Errors:
       Error: AX_ARIA_01 (Elements with ARIA roles must use a valid, non-abstract ARIA role) failed on the following element:
       body > .outer > .standup > .block.buttons
       See https://code.google.com/p/accessibility-developer-tools/wiki/AuditRules#AX_ARIA_01:_Elements_with_ARIA_roles_must_use_a_valid,_non-abstr for more information.


       *** End accessibility audit results ***

Need help? Ask on the mailing list (please do not open an issue on GitHub): https://groups.google.com/forum/#!forum/capybara-accessible

Visit the [wiki](https://github.com/Casecommons/capybara-accessible/wiki) for more background on automated accessibility testing with capybara-accessible.

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

### Disabling audits
You can disable audits on individual tests by tagging the example or group as `inaccessible: true`, and configuring Rspec like so:

    # spec/spec_helper.rb

    RSpec.configure do |config|
      config.around(:each, :inaccessible => true) do |example|
        Capybara::Accessible.skip_audit { example }
      end
    end


    # spec/features/inaccessible_page_spec.rb

    # Blocks tagged inaccessible will skip accessibility assertions.
    # They will still run your other native assertions.
    describe '/inaccessible', inaccessible: true do 
      it 'display an image' do
        page.should have_css 'img'
      end
    end

## Contributing

1. Fork it
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create new Pull Request
