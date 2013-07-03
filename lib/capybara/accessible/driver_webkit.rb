module Capybara::Accessible
  class DriverWebkit < Capybara::Webkit::Driver
    include Capybara::Accessible::Auditor

    def visit(path)
      super
      if audit_failures.any?
        raise Capybara::Accessible::InaccessibleError, failure_messages
      end
    end
  end
end
