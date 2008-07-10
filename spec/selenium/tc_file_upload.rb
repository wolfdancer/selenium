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
      file = File.join(File.dirname(__FILE__), 'screenshot.png')
      puts "image at #{file}"
      @page.capture_screen(file)
      @page.close
    end

    # this requires the user to manually enter the login information on rubyforge, and can only be run by selenium admin
    it 'should handle firefox' do
      login_link = @page.link_by_text('Log In')
      autoit = AutoIt.load
      login_link.click if login_link.present?
      AutoItWindow.wait_for(autoit, 'Website Certified by an Unknown Authority').send_keys(' ')
      @page.wait_for_load
      @page.wait_until('manual login for test') do |message|
        puts message
        not login_link.present?
      end
      @page.wait_for_load
      selenium_project_link = @page.link_by_text('Selenium')
      selenium_project_link.should be_present
      selenium_project_link.click_wait
      @page.link_by_text('Files').click_wait
      @page.link_by_target('/frs/admin/?group_id=2789').click_wait
      @page.link_by_xpath("//a[@href='qrs.php?package_id=3298&group_id=2789']").click_wait
      @page.file_upload('userfile').enter("file:///#{__FILE__}")
    end
  end
end