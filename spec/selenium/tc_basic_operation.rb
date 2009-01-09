require File.dirname(__FILE__) + '/spec_helper'

describe 'basic operation with selenium' do
  before do
    @server = Selenium::Server.on_port(4567)
    @server.start
    @webpage = @server.open(Selenium::BROWSER, 'http://localhost:2000/test/index.html')
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
