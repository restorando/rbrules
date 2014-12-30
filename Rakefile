require "bundler/gem_tasks"

desc "Run gem tests"
task :test do
  require 'rake/testtask'

  Rake::TestTask.new do |t|
    t.pattern = "spec/*_spec.rb"
  end
end

task default: :test
