#START RC
require 'spec'
require 'selenium'

context 'Test goole seart' do
  setup do
    @sel = Selenium::SeleniumDriver.new("localhost", 4444, "*iexplore", "http://www.google.com", 15000)
    @sel.start
  end
		
  specify'searh hello world with google' do
    @sel.open("http://www.google.com/webhp")
    @sel.type("q", "hello world")
    @sel.click("btnG")
    @sel.wait_for_page_to_load("5000")
    @sel.get_title.should == 'hello world - Google Search'
  end
	
  teardown do
    @sel.stop
  end
end
#END RC