require File.join(File.dirname(__FILE__), "spec_helper")

context 'Test goole search' do
  before do
    port = 4567
    @server = Selenium::Server.on_port(port)
    @server.start
    @page = @server.open(BROWSER, 'http://www.google.com')
  end

  after do
    @page.close
    @server.stop
  end

  specify'searh hello world with google using interaction based script' do
    @page.open_page("/")
    @page.title.should == 'Google'
    @page.enter("q", "hello world")
    @page.click("btnG")
    @page.wait_for_load
    @page.title.should == 'hello world - Google Search'
  end

end
#END INTERACTION
