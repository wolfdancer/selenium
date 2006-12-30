module Selenium
class Link
  attr_reader :browser
  
  def Link::by_id(browser, id)
    Link.new(browser, "id=#{id}")
  end
  
  def Link::by_text(browser, text)
    Link.new(browser, "link=#{text}")
  end
  
  def initialize(browser, locator)
    @browser = browser
    @locator = locator
  end
  
  def click
    @browser.click(@locator)
  end
  
  def click_wait
    click
    @browser.wait_for_page_to_load
  end
end
end
