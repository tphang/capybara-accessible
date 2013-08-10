module Capybara::Accessible
  class Driver < Capybara::Selenium::Driver
    include Capybara::Accessible::Auditor

    def visit(path)
      super
      if Capybara.current_driver == :accessible && audit_failures.any?
        if Capybara::Accessible::Auditor.log_level == :warn
          puts failure_messages
        else
          raise Capybara::Accessible::InaccessibleError, failure_messages
        end
      end
    end
  end
end
