require 'spec_helper'

describe Capybara::Accessible::Driver do
  it 'passes the audit for an accessible page' do
    session = Capybara::Session.new(:accessible, AccessibleApp)
    expect { session.visit('/accessible') }.to_not raise_error
  end

  it 'fails the audit for an inaccessible page' do
    session = Capybara::Session.new(:accessible, AccessibleApp)
    expect { session.visit('/inaccessible') }.to raise_error(Capybara::InaccessibleError)
  end
end
