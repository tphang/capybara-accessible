require 'spec_helper'

describe Capybara::Accessible::Driver do
  before do
    @session = Capybara::Session.new(:accessible, AccessibleApp)
  end

  it 'passes the audit for an accessible page' do
    expect { @session.visit('/accessible') }.to_not raise_error
  end

  it 'fails the audit for an inaccessible page' do
    expect { @session.visit('/inaccessible') }.to raise_error(Capybara::Accessible::InaccessibleError)
  end

  it 'fails the audit for an inaccessible page' do
    @session.visit('/accessible')
    expect { @session.click_link('inaccessible') }.to raise_error(Capybara::Accessible::InaccessibleError)
  end
end
