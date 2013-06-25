module Capybara
  module Node
    class Element < Base
      include Capybara::Accessible::Auditor

      def click
        synchronize { base.click }
        if Capybara.current_driver == :accessible && audit_results.any? { |r| r['result'] == 'FAIL' }
          raise Capybara::Accessible::InaccessibleError, failure_messages 
        end
      end
    end
  end
end
