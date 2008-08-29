dir = File.dirname(__FILE__)
selenium_dir = File.expand_path(File.join(dir, '..', '..', '..', 'lib'))
$:.unshift(selenium_dir) unless $:.include?(selenium_dir)

require "selenium"
require "#{dir}/selenium_ruby/selenium_ruby_page"
require "#{dir}/selenium_ruby/home_page"
require "#{dir}/selenium_ruby/directory_listing_page"
require "#{dir}/selenium_ruby/download_page"
require "#{dir}/selenium_ruby/license_page"
require "#{dir}/selenium_ruby/menu"
