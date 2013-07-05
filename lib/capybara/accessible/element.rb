module Capybara
  module Node
    class Element < Base
      include Capybara::Accessible::Auditor

      def click
        synchronize { base.click }
        if @session.driver.is_a? Capybara::Accessible::Driver
          begin
            if audit_failures.any?
              raise Capybara::Accessible::InaccessibleError, failure_messages
            end
          rescue ::Selenium::WebDriver::Error::UnhandledAlertError => e
            puts "Skipping accessibility audit: #{e}"
          end
        elsif @session.driver.is_a? Capybara::Accessible::WebkitDriver
          if webkit_audit_failures.any?
            raise Capybara::Accessible::InaccessibleError, webkit_failure_messages
          end
        end
      end
    end
  end
end
