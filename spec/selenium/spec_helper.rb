require "rubygems"
dir = File.dirname(__FILE__)
$:.unshift File.expand_path(File.join(dir, '..', '..', 'lib'))
require "selenium"

require "spec"
require "mongrel"
require "#{dir}/examples/selenium_ruby"

module Selenium
  BROWSER = RUBY_PLATFORM =~ /^rwin/ ?
    '*chrome D:\Program Files\Mozilla Firefox2\firefox.exe' :
    '*firefox'
end

Spec::Runner.configure do |config|
  config.mock_with :rr
end

Selenium::WaitFor.module_eval do
  def time_class
    @time_class ||= FakeTimeClass.new
  end

  def sleep(time)
  end
end

class FakeTimeClass
  def initialize
    @now = Time.now
  end

  def now
    @now += 1
  end
end

describe "Selenium", :shared => true do
  def result(response_text=nil)
    "OK,#{response_text}"
  end
end

$test_app_server = Mongrel::HttpServer.new("0.0.0.0", "2000")
puts File.expand_path(File.join(dir, '..', '..', 'site'))
$test_app_server.register("/", Mongrel::DirHandler.new(File.expand_path(File.join(dir, '..', '..', 'site'))))
$test_app_server.run

Spec::Example::ExampleGroup.after(:suite) do |success|
  $test_app_server.stop
end
