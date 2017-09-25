require 'bundler/gem_tasks'
require 'rake/testtask'

Rake::TestTask.new do |t|
  t.verbose = true
  t.warning = false
  t.pattern = File.join('test', '**', 'test_*.rb')
end

namespace :test do
  task :coverage do
    ENV['COVERAGE'] = 'true'
    Rake::Task['test'].invoke
  end
end

task(:doc_stats) { ruby '-S yard stats' }
task default: [:test, :doc_stats]
