require File.join(File.dirname(__FILE__), "spec_helper")

context 'Google Search Interaction' do

  before do
    @server = Selenium::Server.on_port(4567)
    @server.start
    @page = @server.open(Selenium::BROWSER, 'http://www.google.com')
  end

  after do
    @page.close
    @server.stop
  end

  specify 'Search hello world with google using interaction based script' do
    @page.open_page("/")
    @page.title.should == 'Google'
    @page.enter("q", "hello world")
    @page.click("btnG")
    @page.wait_for_load
    @page.title.should == 'hello world - Google Search'
  end

end
