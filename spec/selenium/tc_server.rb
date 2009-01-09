require File.join(File.dirname(__FILE__), "spec_helper")

describe 'Server Manager' do

  it 'Supports starting and stopping server on specified port' do
    server = Selenium::Server.on_port(4321)
    server.start
    server.status.should == "started"
    server.stop
    server.status.should == "stopped"
  end

  it 'Supports arguments through start method' do
    server = Selenium::Server.on_port(3333)
    server.start('-timeout 800')
    server.stop
  end

end