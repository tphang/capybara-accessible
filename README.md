# capybara-accessible

## Automated accessibility testing in RSpec and Rails

capybara-accessible introduces accessibility tests into your [integration specs](https://www.relishapp.com/rspec/rspec-rails/docs/feature-specs/feature-spec), 
helping you to capture existing failures and to prevent future regressions.

It works by defining a custom webdriver that runs [Google's Accessibility Developer Tools](https://github.com/GoogleChrome/accessibility-developer-tools)
audits during a test run. Since the audits are invoked automatically on page load, you do not need to make explicit assertions on accessibility. 
Instead, the test will simply fail with a message indicating the failures, like so:

![Error output from an Rspec failure](http://i.imgur.com/8RWEzzg.png)

Some of the audit rules that are included from Google's Accessibility Developer Tools:
* minimum color contrast
* label associations with inputs
* presence of alt attributes
* valid use of ARIA roles

See the [Google Accessibility Developer Tools wiki](https://code.google.com/p/accessibility-developer-tools/wiki/AuditRules) 
for a full list of rules.

Visit the [capybara-accessible wiki](https://github.com/Casecommons/capybara-accessible/wiki) for background on why and how 
we built capybara-accessible.


## Installation

Add `gem 'capybara-accessible'` to your application's Gemfile and run `bundle` on the command line.

## Usage

You can use capybara-accessible as a drop-in replacement for Rack::Test, Selenium or capybara-webkit drivers for Capybara.
Simply set the driver in spec_helper.rb:

    # spec/spec_helper.rb
    require 'capybara/rspec'
    require 'capybara/accessible'

    Capybara.default_driver = :accessible
    Capybara.javascript_driver = :accessible

We suggest that you use [pry-rescue with pry-stack_explorer](https://github.com/ConradIrwin/pry-rescue) 
to debug the accessibility failures in the DOM. pry-rescue will open a debugging session at the first exception, 
pausing the driver so that you can inspect the page.

### Disabling audits
You can disable audits on individual tests by tagging the example or group as `inaccessible: true`, 
and configuring Rspec like so:

    # spec/spec_helper.rb

    RSpec.configure do |config|
      config.around(:each, :inaccessible => true) do |example|
        Capybara::Accessible.skip_audit { example.run }
      end
    end


    # spec/features/inaccessible_page_spec.rb

    # Page loads in examples tagged as inaccessible will not trigger an audit.
    # All other assertions will be made.
    describe '/inaccessible', inaccessible: true do 
      it 'display an image' do
        page.should have_css 'img' # this assertion will still be executed
      end
    end

## Support

If you think you've found a bug, or have installation questions or feature requests, please send a message 
to the [mailing list](https://groups.google.com/forum/#!forum/capybara-accessible).

If you are commenting on the audit rules and failure messages, please check out the Google Accessibility Developer Tools 
Project, and review their guidelines for reporting issues.

## Contributing

NOTE: axs_testing.js is a generated file from 
[Google's Accessibility Developer Tools](https://github.com/GoogleChrome/accessibility-developer-tools). 
If you'd like to contribute to the audit rules, please fork their Github project.
