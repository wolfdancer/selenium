module Selenium
class Button
  attr_reader :browser
  
  def initialize(browser, locator)
    @browser = browser
    @locator = locator
  end
  
  def click
    browser.click(@locator)
  end
  
  def click_wait
    click
    browser.wait_for_page_to_load
  end
end
end