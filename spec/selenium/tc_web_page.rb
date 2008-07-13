require 'spec'

$:.unshift File.join(File.dirname(__FILE__), '..', '..')

require 'lib/selenium'

module Selenium
  describe WebPage do
    before(:all) do
      @server = Server.new(2344)
      @server.start
    end

    after do
      @webpage.close if @webpage
    end

    after(:all) do
      @server.stop
    end

    def webpage
      @webpage = @server.open('*chrome D:\Program Files\Mozilla Firefox2\firefox.exe', 'http://localhost:2000/') unless @webpage
      @webpage
    end

    it 'should have meaningful to_s support' do
      webpage = WebPage.new(SeleniumDriver.new('localhost', 2222, '*chrome', 'http://www.example.com', 60000), 'expected title')
      webpage.to_s.should == 'Selenium::WebPage(\'expected title\') - SeleniumDriver'
    end

    it 'should create link based on text' do
      webpage = WebPage.new('browser')
      webpage.link(:text, 'text').locator.should == 'link=text'
    end

    it 'should create link based on href' do
      webpage = WebPage.new('browser')
      webpage.link(:href, 'a.html').locator.should == "xpath=//a[@href='a.html']"
    end

    it 'should support double click' do
      webpage.open_page('/test/index.html')
      webpage.enter('doubleclick', 'webpage')
      webpage.double_click('doubleclick')
      webpage.should be_alert_present
      webpage.alert_message.should == 'double clicked with value webpage'
    end
  end
end
