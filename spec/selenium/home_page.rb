require "#{File.dirname(__FILE__)}/spec_helper"

module Selenium
class HomePage < SeleniumRubyPage

  def initialize(browser)
    super(browser, 'Selenium Ruby - Home')
  end
  
end
end