module Selenium
class TextField
  attr_reader :browser
  
  def initialize(browser, locator)
    @browser = browser
    @locator = locator
  end
  
  def type(value)
    @browser.type(@locator, value)
  end
  
  def value
    @browser.get_value(@locator)
  end
end
end