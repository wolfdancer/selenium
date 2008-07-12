require 'spec'

$:.unshift File.join(File.dirname(__FILE__), '..', '..')

require 'lib/selenium'

module Selenium
  describe WebPage do
    it 'should create link based on text' do
      webpage = WebPage.new('browser')
      webpage.link(:text, 'text').locator.should == 'link=text'
    end

    it 'should create link based on href' do
      webpage = WebPage.new('browser')
      webpage.link(:href, 'a.html').locator.should == "xpath=//a[@href='a.html']"
    end
  end
end
