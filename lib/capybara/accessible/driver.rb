module Capybara
  class InaccessibleError < CapybaraError; end
end

module Capybara::Accessible
  class Driver < Capybara::Selenium::Driver
    def visit(path)
      browser.navigate.to(path)
      raise Capybara::InaccessibleError, failure_messages if audit_results.any? { |r| r['result'] == 'FAIL' }
    end

    private

    def audit_results
      excluded_assertions = %w{ AX_FOCUS_01 AX_FOCUS_02 AX_COLOR_01 }
      results = execute_script("#{audit_rules} return axs.Audit.run();")
      results.reject do |r|
        excluded_assertions.include?(r['rule']['code'])
      end
    end

    def failure_messages
      audit_results.collect do |f|
        "<#{f['elements'].first.tag_name}> tag with text \"#{f['elements'].first.text}\" - #{f['rule']['heading']}" if f['result'] == 'FAIL'
      end.join("\n")
    end

    def audit_rules
      File.read(File.expand_path("../axs_testing.js", __FILE__))
    end
  end
end
