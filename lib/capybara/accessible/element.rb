module Capybara
  module Node
    class Element < Base
      include Capybara::Accessible::Auditor

      def click
        synchronize { base.click }
        if Capybara.current_driver == :accessible
          begin
            if audit_failures.any?
              raise Capybara::Accessible::InaccessibleError, failure_messages
            end
          rescue ::Selenium::WebDriver::Error::UnhandledAlertError => e
            puts "Skipping accessibility audit: #{e}"
          end
        elsif Capybara.current_driver == :accessible_webkit
          if webkit_audit_failures.any?
            raise Capybara::Accessible::InaccessibleError, webkit_failure_messages
          end
        end
      end
    end
  end
end
