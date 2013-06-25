module Capybara::Accessible
  class InaccessibleError < Capybara::CapybaraError; end

  module Auditor
    def audit_rules
      File.read(File.expand_path("../axs_testing.js", __FILE__))
    end

    def audit_results
      excluded_assertions = %w{ AX_FOCUS_01 AX_FOCUS_02 AX_COLOR_01 }
      results.reject do |r|
        excluded_assertions.include?(r['rule']['code'])
      end
    end

    def failure_messages
      results.collect do |f|
        "<#{f['elements'].first.tag_name}> tag with text \"#{f['elements'].first.text}\" - #{f['rule']['heading']}" if f['result'] == 'FAIL'
      end.join("\n")
    end

    def results
      script = "#{audit_rules} return axs.Audit.run();"

      if @session
        @session.driver.execute_script(script)
      else
        execute_script(script)
      end
    end
  end
end
