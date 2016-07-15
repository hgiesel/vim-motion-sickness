require 'rspec/core/rake_task'

RSpec::Core::RakeTask.new :spec do |t|
  t.pattern    = 'spec/*-spec.rb'
  t.rspec_opts = "--fail-fast"
end

task :default => :spec
