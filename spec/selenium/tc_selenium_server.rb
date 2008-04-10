require 'spec'

$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'selenium'

module Selenium
describe 'selenium server' do
  it 'start and stop server' do
    server = ServerManager.new()
    puts 'starting server...'
    server.start
    server.status.should == "started"
    puts 'stopping server...'
    server.stop
    server.status.should == "stopped"
  end

  it 'supports starting and stopping server on specified port' do
    server = ServerManager.on_port(4321)
    server.start
    server.status.should == "started"
    server.stop
    server.status.should == "stopped"
  end
end

end