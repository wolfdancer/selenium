require "rubygems"
dir = File.dirname(__FILE__)
$:.unshift File.expand_path(File.join(dir, '..', '..', 'lib'))
require "selenium"

require "spec"
require "#{dir}/examples/selenium_ruby"

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
