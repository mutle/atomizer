require 'bundler'
Bundler::GemHelper.install_tasks

require 'rake/testtask'

namespace :test do
  Rake::TestTask.new(:units) do |t|
    t.libs << "test"
    t.pattern = 'test/unit/**/*_test.rb'
  end
end
