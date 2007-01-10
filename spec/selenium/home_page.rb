$:.unshift File.dirname(__FILE__)
require 'menu'

$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib', 'selenium')

require 'link'

module Selenium
class HomePage
  include Menu
  attr_reader :browser

  def initialize(browser)
    @browser = browser
  end
  
end
end