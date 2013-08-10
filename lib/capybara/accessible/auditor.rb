module Capybara::Accessible
  class InaccessibleError < Capybara::CapybaraError; end

  class << self
    def skip_audit
      @disabled = true
      yield
    ensure
      @disabled = false
    end
  end

  module Auditor
    def self.exclusions=(rules)
      @@exclusions = rules
    end

    def self.exclusions
      @@exclusions ||= []
    end

    def self.log_level=(level)
      @@log_level= level
    end

    def self.log_level
      @@log_level ||= :error
    end

    def audit_rules
      File.read(File.expand_path("../../../vendor/google/accessibility-developer-tools/axs_testing.js", __FILE__))
    end

    def audit_failures
      if Capybara::Accessible.instance_variable_get(:@disabled)
        []
      else
        run_script("#{perform_audit_script} return axs.Audit.auditResults(results).getErrors();")
      end
    end

    def failure_messages
      "Found at #{page_url} \n\n" + run_script("#{perform_audit_script} return axs.Audit.createReport(results)")
    end

    private

    def perform_audit_script
      <<-JAVASCRIPT
        #{audit_rules}
        var config = new axs.AuditConfiguration();
        config.auditRulesToIgnore = #{excluded_rules.to_json};
        var results = axs.Audit.run(config);
      JAVASCRIPT
    end

    def excluded_rules
      codes = Capybara::Accessible::Auditor.exclusions
      mapping = {
        'AX_ARIA_01' => 'badAriaRole',
        'AX_ARIA_02' => 'nonExistentAriaLabelledbyElement',
        'AX_ARIA_03' => 'requiredAriaAttributeMissing',
        'AX_ARIA_04' => 'badAriaAttributeValue',
        'AX_TEXT_01' => 'controlsWithoutLabel',
        'AX_TEXT_02' => 'imagesWithoutAltText',
        'AX_TITLE_01' => 'pageWithoutTitle',
        'AX_IMAGE_01' => 'elementsWithMeaningfulBackgroundImage',
        'AX_FOCUS_01' => 'focusableElementNotVisibleAndNotAriaHidden',
        'AX_FOCUS_02' => 'unfocusableElementsWithOnClick',
        'AX_COLOR_01' => 'lowContrastElements',
        'AX_VIDEO_01' => 'videoWithoutCaptions',
        'AX_AUDIO_01' => 'audioWithoutControls'
        # 'AX_TITLE_01' => 'linkWithUnclearPurpose', # This has a duplicate name
        # 'AX_ARIA_05' => '', # This has no rule associated with it
      }

      codes.map { |code| mapping[code]}
    end

    def page_url
      @session ? @session.driver.current_url : current_url
    end

    def run_script(script)
      if @session
        @session.driver.execute_script(script)
      else
        execute_script(script)
      end
    end
  end
end
