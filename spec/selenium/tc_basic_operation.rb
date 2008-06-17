require "#{File.dirname(__FILE__)}/spec_helper"

module Selenium
describe 'basic operation with selenium' do
  
  before do
    port = 4567
    @server = Selenium::Server.on_port(port)
    @server.start
    if RUBY_PLATFORM =~ /[^r]win/
      @browser = Selenium::SeleniumDriver.new("localhost", port, "*iexplore", "http://localhost:2000", 10000)
    else
      @browser = Selenium::SeleniumDriver.new("localhost", port, "*firefox", "http://localhost:2000", 10000)
    end
    @browser.start
    @browser.open('http://localhost:2000/index.html')
  end

  after do
    @browser.stop
    @server.stop
  end
  
  it 'should click through menus' do
=begin comment
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
=end comment
  end
end
end