$:.unshift File.join(File.dirname(__FILE__), '..', '..')

require 'lib/selenium/auto_it'
require 'lib/selenium'
require 'spec'

module Selenium
  describe FileUpload do
    before(:all) do
      @server = Server.on_port(4440)
      @server.start
    end

    after(:all) do
      @server.stop
    end

    before do
      @page = @server.open('*chrome D:\Program Files\Mozilla Firefox2\firefox.exe', 'http://www.rubyforge.org/projects/selenium')
    end

    after do
      @page.close
    end

    # this requires the user to manually enter the login information on rubyforge, and can only be run by selenium admin
    it 'should handle firefox' do
      @page.wait_for_load
      @page.wait_until('manual login for test') do |message|
        puts message
        not @page.link_by_text('Log In').present?
      end
    end
  end
end