require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'yard'

RSpec::Core::RakeTask.new(:spec)
YARD::Rake::YardocTask.new(:yard)

task default: :spec

desc 'Start an IRB session in the context of the current bundle'
task :irb do
	sh 'bundle console'
end
