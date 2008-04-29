require 'spec'

$:.unshift File.join(File.dirname(__FILE__), '..', '..', 'lib')

require 'selenium'

module Selenium
describe 'server manager' do
  it 'start and stop server' do
    server = Server.new()
    puts 'starting server...'
    server.start
    server.status.should == "started"
    puts 'stopping server...'
    server.stop
    server.status.should == "stopped"
  end

  it 'supports starting and stopping server on specified port' do
    server = Server.on_port(4321)
    server.start
    server.status.should == "started"
    server.stop
    server.status.should == "stopped"
  end

  it 'should support arguments through start method' do
    server = Server.on_port(3333)
    server.start('-timeout 800')
    server.stop
  end
end

end