# frozen_string_literal: true

require "rake/testtask"

task default: :test

Rake::TestTask.new(:test) do |t|
  t.libs << "test"
  t.libs << "lib"
  t.test_files = FileList["test/**/*_test.rb"]
end

desc "Build the gem"
task :build do
  sh "gem build zen-and-musashi.gemspec"
end

desc "Install the gem locally"
task install: :build do
  sh "gem install zen-and-musashi-#{ZenAndMusashi::VERSION}.gem"
end
