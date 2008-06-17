require "rubygems"
$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib')
require "selenium"

$:.unshift File.dirname(__FILE__)
require 'web_page'
require 'selenium_ruby_page'
require 'home_page'
require 'directory_listing_page'
require 'license_page'
require 'menu'
require 'download_page'

require "spec"