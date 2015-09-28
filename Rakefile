require 'bundler/gem_tasks'
require 'rake/testtask'
require 'rubocop/rake_task'

Rake::TestTask.new do |task|
  task.libs << 'lib/hijri_date'
  task.test_files = FileList['test/*_test.rb']
end
task default: [:test]

RuboCop::RakeTask.new(:rubocop)
task default: [:rubocop]
