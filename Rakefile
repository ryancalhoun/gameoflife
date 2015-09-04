require 'rake/testtask'

Rake::TestTask.new {|t|
	t.libs << 'test'
}

desc 'Run tests'
task :default => :test

desc "Run game in console"
task :console do
	sh "ruby -Ilib driver/console.rb"
end

desc "Run game in browser"
task :web do
	sh "ruby -Ilib driver/web.rb #{ENV['PORT']}"
end

