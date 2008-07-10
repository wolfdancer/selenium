$:.unshift File.dirname(__FILE__)

require 'timeout'

module Selenium
  # Class that models a web page with a title
  class WebPage
    attr_reader :browser
    attr_accessor :timeout, :interval_millis

    def initialize(browser, expected_title = nil)
      @browser = browser
      @expected_title = expected_title
      @timeout = 60
      @interval_millis = 100
    end

    def title
      @browser.get_title
    end

    def html
      @browser.get_html_source
    end

    def wait_for_load
      @browser.wait_for_page_to_load
    end

    def wait_until(message, &block)
      Timeout::timeout(timeout, "Timeout waiting for : #{message}") do
        while(not yield message)
          sleep interval_millis / 1000.0
        end
      end
    end

    def link_by_text(text, target=nil)
      Link.new(self, "link=#{text}", target)
    end

    def link_by_xpath(xpath, target=nil)
      Link.new(self, "xpath=#{xpath}", target)
    end

    def link_by_target(uri, target=nil)
      link_by_xpath("//a[@href='#{uri}']", target)
    end

    def file_upload(name)
      FileUpload.new(self, name)
    end

    def close
      @browser.stop
    end

    def click(locator)
      @browser.click(locator)
    end

    def click_wait(locator)
      click(locator)
      wait_for_load
    end

    def upload(locator, file)
      @browser.attach_file(locator, file)
    end

    def capture_page(file)
      @browser.capture_entire_page_screenshot(file)
    end

    def capture_screen(file)
      @browser.capture_screenshot(file)
    end
	
  end
end