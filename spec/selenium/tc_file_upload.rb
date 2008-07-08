$:.unshift File.join(File.dirname(__FILE__), '..', '..')

require 'lib/selenium/auto_it'
require 'lib/selenium'
require 'spec'

module Selenium
  describe FileUpload do
    before do
      @server = Server.on_port(4440)
      @server.start
    end

    after do
      @server.stop
    end

    it 'should handle firefox' do
      browser = @server.driver('*chrome D:\Program Files\Mozilla Firefox2\firefox.exe', 'http://www.rubyforge.org')
      browser.start
      browser.open('projects/selenium/')
      browser.wait_for_page_to_load
      while (browser.is_element_present('link=Log In')) do
        print("waiting for log in for test\n")
        sleep(30)
      end
      browser.stop
    end
  end
end