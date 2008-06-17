require "#{File.dirname(__FILE__)}/spec_helper"

module Selenium
class DownloadPage < SeleniumRubyPage
  def initialize(browser)
    super(browser, 'Selenium Ruby - Download')
  end
end  
end
