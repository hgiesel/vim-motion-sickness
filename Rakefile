require 'rspec/core/rake_task'

task :default => [:spec]

RSpec::Core::RakeTask.new :spec do |t|
  t.pattern    = 'spec/*-spec.rb'
  t.rspec_opts = "--fail-fast"
end
