require "bundler/gem_tasks"
require 'rspec/core/rake_task'

Bundler::GemHelper.install_tasks

RSpec::Core::RakeTask.new do |t|
  t.pattern = "spec/**/*_spec.rb"
  t.rspec_opts = "--format progress"
end

desc "Default: run all specs"
task :default => [:spec]

desc "Build: fetch and compile javascript assertions project"
task :build do
  system "git submodule init && git submodule update"
  system "cd ./vendor/accessibility-developer-tools/ && make js"
  system "gem build capybara-accessible.gemspec"
end
