module Selenium

  # Link class that models the behavior of a link
  class Link
    attr_reader :webpage, :locator

    def Link::by_id(browser, id, target = nil)
      Link.new(WebPage.new(browser), "id=#{id}", target)
    end

    def Link::by_text(browser, text, target = nil)
      Link.new(WebPage.new(browser), "link=#{text}", target)
    end

    def initialize(webpage, locator, target = nil)
      webpage = WebPage.new(webpage) if webpage.is_a? SeleniumDriver
      @webpage = webpage
      @locator = locator
      @target = target
    end

    def browser
      webpage.browser
    end

    def present?
      webpage.browser.is_element_present @locator
    end

    # click the link
    def click
      @webpage.click(@locator)
    end

    # click the link and wait for page to load
    def click_wait
      @webpage.click_wait(@locator)
    end

    # click the link, wait for the page to load, and asserts the target that
    # was passed in during initialization
    def go
      raise "target page not defined for link #{@locator}" unless @target
      click_wait
      @target.assert_page if target
      @target
    end
  end
end
