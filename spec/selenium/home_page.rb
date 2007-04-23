$:.unshift File.dirname(__FILE__)
require 'menu'
require 'selenium_ruby_page'

$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib', 'selenium')

require 'link'

module Selenium
class HomePage < SeleniumRubyPage

  def initialize(browser)
    super(browser, 'Selenium Ruby - Home')
  end
  
end
end