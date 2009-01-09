require File.join(File.dirname(__FILE__), "spec_helper")

context 'Google Search' do

  class GoogleHomePage < Selenium::WebPage

    def initialize(browser)
      super browser, 'Google'
    end

    def title
      browser.get_title
    end

    def search_field
      text_field :name, 'q'
    end

    def search_button
      button :name, 'btnG'
    end

  end
  
  before(:all) do
    @server = Selenium::Server.on_port(4567)
    @server.start
  end

  before(:each) do
    @webpage = @server.open(Selenium::BROWSER, 'http://www.google.com/webhp')
  end

  after(:each) do
    @webpage.close if @webpage
  end

  after(:all) do
    puts "stopping server"
    @server.stop
  end

  specify'Search hello world with Google using domain based script' do
    page = GoogleHomePage.new(@webpage.browser)
    page.should be_present
    page.search_field.enter 'hello world'
    page.search_button.click_wait
    page.title.should == 'hello world - Google Search'
    page.search_field.value.should == 'hello world'
  end

end
