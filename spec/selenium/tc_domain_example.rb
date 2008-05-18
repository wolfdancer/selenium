$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'spec'
require 'selenium'

#START GOOGLEHOME
class GoogleHomPage
  include Selenium::Locator
  attr_reader :browser

  def GoogleHomPage::open(sel)
    sel.open("http://www.google.com/webhp")
    GoogleHomPage.new(sel)
  end

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
#END GOOGLEHOME

context 'Test goole search' do
  before do
    port = 4567
    @server = Selenium::Server.on_port(port)
    @server.start
    @sel = Selenium::SeleniumDriver.new("localhost", port, "*chrome", "http://www.google.com", 15000)
    @sel.start
  end

  after do
    @sel.stop
    @server.stop
  end

#START DOMAIN
  specify'searh hello world with google using docmain based script' do
    page = GoogleHomPage.open(@sel)
    page.search_field.type('hello world')
    page.search_button.click_wait
    page.title.should == 'hello world - Google Search'
    page.search_field.value.should == 'hello world'
  end
#END DOMAIN

end
