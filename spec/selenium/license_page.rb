require "#{File.dirname(__FILE__)}/spec_helper"

module Selenium
  class LicensePage < SeleniumRubyPage
    def initialize(browser)
      super(browser, 'Selenium Ruby - License')
    end
  end
end