require 'spec'
require 'buildmaster/cotta'
require 'buildmaster/project/server_manager'

$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib', 'selenium')

require 'selenium_server'

module Selenium
context 'selenium server' do
  specify 'start and stop server' do
    server = BuildMaster::ServerManager.new(SeleniumServer.new(4321))
    puts 'starting server...'
    server.start
    puts 'stopping server...'
    server.stop
  end
end
end