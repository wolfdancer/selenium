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
      raise 'nil as browser' unless @browser
      @browser.get_title
    end

    def present?
      title == @expected_title
    end

    def ensure_present
      title.should == @expected_title
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

    def link(how, what=nil)
      if (how == :text)
        locator = "link=#{what}"
      elsif (how == :href)
        locator = "xpath=//a[@href='#{what}']"
      else
        locator = element_locator(how, what)
      end
      Link.new(self, locator)
    end

    def text_field(how, what=nil)
      TextField.new(self, element_locator(how, what))
    end

    def element(how, what=nil)
      HtmlElement.new(self, element_locator(how,what))
    end

    def element_locator(how, what=nil)
      locator = how
      if (not what.nil?)
        if (how == :xpath or how == :name or how == :id)
          locator = "#{how}=#{what}"
        else
          raise "couldn't understand how to build locator using #{how} with #{what}"
        end
      end
    end

    def file_upload(how, what)
      FileUpload.new(self, element_locator(how, what))
    end

    def open_page(url)
      @browser.open(url)
      wait_for_load
    end

    def close
      @browser.stop
    end

    def click(locator)
      @browser.click(locator)
    end

    def text(locator)
      @browser.get_text(locator)
    end

    def button(how, what=nil)
      Button.new(self, element_locator(how, what))
    end

    def element_present?(locator)
      @browser.is_element_present(locator)
    end

    def text_present?(text)
      @browser.is_text_present(text)
    end

    def click_wait(locator)
      click(locator)
      wait_for_load
    end

    # enter the text to the element found by locator
    def enter(locator, text)
      @browser.type(locator, text)
    end

    def value(locator)
      @browser.get_value(locator)
    end

    def upload(locator, file)
#      @browser.attach_file(locator, file)
      @browser.click(locator)
      require 'auto_it'
      autoit = AutoIt.load
      window = AutoItWindow.wait_for(autoit, 'File Upload')
      puts window
    end

    def capture_page(file)
      @browser.capture_entire_page_screenshot(file)
    end

    def capture_screen(file)
      @browser.capture_screenshot(file)
    end
	
  end
end