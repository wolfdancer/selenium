$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib', 'selenium')

require 'web_page'

$:.unshift File.dirname(__FILE__)

require 'menu'

module Selenium
  class SeleniumRubyPage < WebPage
    attr_reader :menu

    def initialize(browser, expected_title)
      super(browser, expected_title)
    end

    def assert_page
      title.should == @expected_title
    end

    def menu
      Menu.new(@browser)
    end
  end
end