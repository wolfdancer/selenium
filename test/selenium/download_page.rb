$:.unshift File.dirname(__FILE__)
require 'menu'

module Selenium
class DownloadPage
  include Menu
  attr_reader :browser
  
  def initialize(browser)
    @browser = browser
  end
end  
end
