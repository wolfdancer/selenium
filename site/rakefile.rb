$:.unshift File.join(File.dirname(__FILE__), '..')

# Example usage of server manager and selenium server
# Thanks to http://svn.caldersphere.net/svn/main/rspec_selenium_rc/trunk/Rakefile
# 

# START RAKE
require 'lib/selenium'
require 'rake'
require 'spec/rake/spectask'

manager = Selenium::ServerManager.new(Selenium::SeleniumServer.new)

task :default => [:acceptance_cycle]

task :start_server do
  manager.start
end

task :stop_server do
  manager.stop
end

Spec::Rake::SpecTask.new('example') do |t|
  t.spec_files = FileList['selenium*example.rb']
end

task :acceptance_cycle do
  begin
    Rake::Task['start_server'].invoke
    Rake::Task['example'].invoke
  ensure
    Rake::Task['stop_server'].invoke
  end
end
# END RAKE
