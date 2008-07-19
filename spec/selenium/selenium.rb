$:.unshift File.join(File.dirname(__FILE__), '..', '..')

require 'spec'
require 'lib/selenium'

module Selenium
  BROWSER = RUBY_PLATFORM =~ /^rwin/ ?
    '*chrome D:\Program Files\Mozilla Firefox2\firefox.exe' :
    '*chrome /usr/lib/firefox-2/firefox'
end