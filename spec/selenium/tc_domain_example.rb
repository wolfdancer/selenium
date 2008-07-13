$:.unshift File.join(File.dirname(__FILE__))

require 'spec'
require '../../lib/selenium'

#START GOOGLEHOME
class GoogleHomPage < WebPage
  def initialize(browser)
    super(browser, 'Google')
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
    @webpage = @server.open('*chrome D:\Program Files\Mozilla', "http://www.google.com")
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
