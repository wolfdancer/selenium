require "rubygems"
$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib')
require "selenium"

$:.unshift File.dirname(__FILE__)
require 'web_page'
require 'selenium_ruby_page'
require 'home_page'
require 'directory_listing_page'
require 'license_page'
require 'menu'
require 'download_page'

require "spec"

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
