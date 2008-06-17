require "#{File.dirname(__FILE__)}/spec_helper"

module Selenium
  class Menu
    attr_reader :browser
    def initialize(browser)
      @browser = browser
    end
  def home_link
    # todo there should be a way to alter this instance so that the click returns the directory listing page
    Link.by_id(browser, 'home', DirectoryListingPage.new(@browser))
  end
  
#MENU START
  def download_link
    Link.by_text(browser, 'Download')
  end
  
  def license_link
    Link.by_text(browser, 'License', LicensePage.new(@browser))
  end
#MENU END
end
end