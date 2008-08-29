require File.join(File.dirname(__FILE__), "spec_helper")

module Selenium
describe 'basic operation with selenium' do
  before do
    port = 4567
    @server = Selenium::Server.on_port(port)
    @server.start
    @webpage = @server.open(BROWSER, 'http://localhost:2000/test/index.html')
    @browser = @webpage.browser
  end

  after do
    @browser.stop
    @webpage.close
    @server.stop
  end
  
  it 'should click through menus' do
  end
end
end