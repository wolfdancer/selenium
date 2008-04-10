require 'spec'

$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'selenium'

module Selenium
describe 'selenium server' do
  it 'start and stop server' do
    server = ServerManager.new()
    puts 'starting server...'
    server.start
    puts 'stopping server...'
    server.stop
  end
end
end