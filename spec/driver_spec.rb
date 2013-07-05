require 'spec_helper'

describe Capybara::Accessible::Driver do
  before do
    @session = Capybara::Session.new(:accessible, AccessibleApp)
  end

  context 'a page without accessibility errors' do
    it 'does not raise an exception on audit failures' do
      expect { @session.visit('/accessible') }.to_not raise_error
    end
  end

  context 'a page with inaccessible elements' do
    it 'raises an exception on visiting the page' do
      expect { @session.visit('/inaccessible') }.to raise_error(Capybara::Accessible::InaccessibleError)
    end

    it 'raises an exception when visiting the page via a link' do
      @session.visit('/accessible')
      expect { @session.click_link('inaccessible') }.to raise_error(Capybara::Accessible::InaccessibleError)
    end

    context 'with configuration that excludes rules' do
      before do
        Capybara::Accessible::Auditor.exclusions = ['AX_TEXT_01']
      end

      it 'does not raise an error on an excluded rule' do
        expect { @session.visit('/excluded') }.to_not raise_error(Capybara::Accessible::InaccessibleError)
      end
    end
  end

  context 'a page with a javascript popup' do
    it 'does not raise an exception' do
      @session.visit('/alert')
      expect { @session.click_link('Alert!') }.to_not raise_error
    end
  end

  context 'a test tagged as inaccessible' do
    it 'does not get run', inaccessible: true  do
      true.should == false
    end
  end
end
