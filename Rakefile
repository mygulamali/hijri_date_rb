begin
  require 'bundler/gem_tasks'
  require 'rake/testtask'

  Rake::TestTask.new do |task|
    task.libs << 'lib/hijri_date'
    task.test_files = FileList['test/*_test.rb']
  end

  task default: [:test]
rescue LoadError
end

begin
  require 'rubocop/rake_task'
  RuboCop::RakeTask.new(:rubocop)

  task default: [:rubocop]
rescue LoadError
end
