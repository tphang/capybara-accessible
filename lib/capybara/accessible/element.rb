module Capybara
  module Node
    class Element < Base
      include Capybara::Accessible::Auditor

      def click
        synchronize { base.click }
        begin
          @session.driver.browser.switch_to.alert
          puts "Skipping accessibility audit: Modal dialog present"
        rescue ::Selenium::WebDriver::Error::NoAlertOpenError
          if Capybara.current_driver == :accessible && audit_failures.any?
            raise Capybara::Accessible::InaccessibleError, failure_messages
          end
        end
      end
    end
  end
end
