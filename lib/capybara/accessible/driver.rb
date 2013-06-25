module Capybara::Accessible
  class Driver < Capybara::Selenium::Driver
    include Capybara::Accessible::Auditor

    def visit(path)
      super
      if audit_results.any? { |r| r['result'] == 'FAIL' }
        raise Capybara::Accessible::InaccessibleError, failure_messages
      end
    end
  end
end
