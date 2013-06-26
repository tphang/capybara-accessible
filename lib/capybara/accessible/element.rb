module Capybara
  module Node
    class Element < Base
      include Capybara::Accessible::Auditor

      def click
        synchronize { base.click }
        begin
          if Capybara.current_driver == :accessible && audit_results.any? { |r| r['result'] == 'FAIL' }
            raise Capybara::Accessible::InaccessibleError, failure_messages
          end
        rescue ::Selenium::WebDriver::Error::UnhandledAlertError => e
          puts "Skipping accessibility audit: #{e}"
        end
      end
    end
  end
end
