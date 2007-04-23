require 'spec'

$:.unshift File.join(File.dirname(__FILE__), '..', '..')

require 'lib/selenium'
require 'spec/selenium/home_page'
require 'spec/selenium/download_page'

module Selenium
context 'basic operation with selenium' do
  context_setup do
  end
  
  setup do
    @browser = Selenium::SeleniumDriver.new("localhost", 4444, "*iexplore", "http://localhost:2000", 10000)
    @browser.start
    @browser.open('http://localhost:2000/index.html')
  end
  
  specify 'click through menus' do
#TEST START
    page = HomePage.new(@browser)
    page.menu.download_link.click_wait
    page = DownloadPage.new(@browser)
    page.assert_page
    page = page.menu.home_link.go
    page.link_to_entry('index.txt').click_wait
    page = HomePage.new(@browser)
    page.menu.license_link.go
#TEST END
  end
end
end