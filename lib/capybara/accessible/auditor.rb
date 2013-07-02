module Capybara::Accessible
  class InaccessibleError < Capybara::CapybaraError; end

  module Auditor
    def self.exclusions=(rules)
      @@exclusions = rules
    end

    def self.exclusions
      @@exclusions ||= []
    end

    def audit_rules
      File.read(File.expand_path("../axs_testing.js", __FILE__))
    end

    def audit_failures
      script =<<-JAVASCRIPT
        var config = new axs.AuditConfiguration();
        config.auditRulesToIgnore = #{excluded_rules.to_json};
        results = axs.Audit.run(config);
        return axs.Audit.auditResults(results).getErrors();
      JAVASCRIPT

      run_script("#{audit_rules} #{script}")
    end

    def failure_messages
      run_script("#{audit_rules} var results = axs.Audit.run(); return axs.Audit.createReport(results)")
    end

    private

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

      names = codes.map { |code| mapping[code]}
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
