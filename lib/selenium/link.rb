module Selenium

  # Link class that models the behavior of a link
  class Link
    attr_reader :browser

    def Link::by_id(browser, id, target = nil)
      Link.new(browser, "id=#{id}", target)
    end

    def Link::by_text(browser, text, target = nil)
      Link.new(browser, "link=#{text}", target)
    end

    def initialize(browser, locator, target = nil)
      @browser = browser
      @locator = locator
      @target = target
    end

    # click the link
    def click
      @browser.click(@locator)
    end

    # click the link and wait for page to load
    def click_wait
      click
      @browser.wait_for_page_to_load(30000)
    end

    # click the link, wait for the page to load, and asserts the target that
    # was passed in during initialization
    def go
      raise "target page not defined for link #{@locator}" unless @target
      click_wait
      @target.assert_page
      @target
    end
  end
end
