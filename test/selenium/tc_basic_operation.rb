require 'spec'

$:.unshift File.join(File.dirname(__FILE__), '..', '..')

require 'lib/selenium'
require 'test/selenium/home_page'
require 'test/selenium/download_page'

module Selenium
context 'basic operation with selenium' do
  context_setup do
    @browser = Selenium::SeleniumDriver.new("localhost", 4444, "*iexplore", "http://localhost:2000", 10000)
    @browser.start
  end
  
  setup do
    @browser.open('http://localhost:2000/index.html')
  end
  
  specify 'click through menus' do
#TEST START
    page = HomePage.new(@browser)
    page.download_link.click_wait
    page = DownloadPage.new(@browser)
    page.home_link.click_wait
    page = DirectoryListingPage.new(@browser)
    page.link_to_entry('index.txt').click_wait
#TEST END
  end
end
end