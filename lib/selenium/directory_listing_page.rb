$:.unshift File.dirname(__FILE__)
require 'link'

module Selenium
class DirectoryListingPage
  attr_reader :browser
  
  def initialize(browser)
    @browser = browser
  end
  
  def link_to_entry(text)
    Link.new(browser, "link=#{text}")
  end

  def assert_page
    @browser.get_title.should == 'Index of /'
  end
end
end