$:.unshift File.dirname(__FILE__)

module Selenium
  # Class that models a web page with a title
  class WebPage
    attr_reader :title

    def initialize(browser, expected_title)
      @browser = browser
      @expected_title = expected_title
    end

    def title
      @browser.get_title
    end
	
  end
end