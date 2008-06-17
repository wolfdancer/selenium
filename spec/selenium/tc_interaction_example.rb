require "#{File.dirname(__FILE__)}/spec_helper"

context 'Test goole search' do
  before do
    port = 4567
    @server = Selenium::Server.on_port(4567)
    @server.start
    @sel = Selenium::SeleniumDriver.new("localhost", port, "*chrome", "http://www.google.com", 15000)
    @sel.start
  end

  after do
    @sel.stop
    @server.stop
  end

  specify'searh hello world with google using interaction based script' do
    @sel.open("http://www.google.com")
    @sel.type("q", "hello world")
    @sel.click("btnG")
    @sel.wait_for_page_to_load("5000")
    @sel.get_title.should == 'hello world - Google Search'
  end

end
#END INTERACTION
