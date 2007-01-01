require 'spec'

$:.unshift File.join(File.dirname(__FILE__), '..')

require 'lib/selenium'

class GoogleHomPage
  include Selenium::Locator
  attr_reader :browser
  def initialize(browser)
    @browser = browser
  end
  
  def title
    browser.get_title
  end
  
  def search_field
    Selenium::TextField.new(browser, by_name('q'))
  end
  
  def search_button
    Selenium::Button.new(browser, by_name('btnG'))
  end
    
end
context 'Test goole seart' do
  setup do
    @sel = Selenium::SeleniumDriver.new("localhost", 4444, "*iexplore", "http://www.google.com", 15000)
    @sel.start
  end
		
#START OBJECT
  specify'searh hello world with google' do
    @sel.open("http://www.google.com/webhp")
    page = GoogleHomPage.new(@sel)
    page.search_field.type('hello world')
    page.search_button.click_wait
    page.title.should == 'hello world - Google Search'
    page.search_field.value.should == 'hello world'
  end
#END OBJECT	
  teardown do
    @sel.stop
  end
end
