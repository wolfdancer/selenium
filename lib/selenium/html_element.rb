module Selenium
  class HtmlElement
    attr_reader :webpage, :locator
    def initialize(webpage, locator)
      webpage = WebPage.new(webpage) if webpage.is_a? SeleniumDriver
      @webpage = webpage
      @locator = locator
    end

    def browser
      webpage.browser
    end

    def present?
      webpage.browser.is_element_present @locator
    end

    # click the element
    def click
      @webpage.click(@locator)
    end

    # click the element and wait for page to load
    # TODO: wait on block instead if givven
    def click_wait
      @webpage.click_wait(@locator)
    end

  end
end