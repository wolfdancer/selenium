module Selenium
# The class that can manages the server driver classes.
# This class is copied from the BuildMaster project.
# You can setup your build task to start the server before 
# the tests and shutdown when it is finished
#   manager = Selenium::ServerManager.new(Selenium::Server.new)
#   begin
#     manager.start
#     tests.run # run your tests here
#   ensure
#     manager.stop
#   end
class ServerManager
  # The status of the server.  Values are
  # * stopped
  # * starting
  # * started
  # * stopping
  # * error
  attr_reader :status

  def initialize(server = SeleniumServer.new)
    @server = server
    @status = 'stopped'
  end
  
  # Starts the server, returns when the server is up and running
  def start
    starting_server
    wait_for_condition {@server.running?}
    @status = 'started'
  end
  
  # Stops the server, returns when the server is no longer running
  def stop
    stopping_server
    wait_for_condition {not @server.running?}
    @status = 'stopped'
  end

  private
  def starting_server
    @status = 'starting'
    ['INT', 'TERM'].each { |signal|
         trap(signal){ @server.stop} 
    }  
    start_thread {@server.start}
  end
  
  def stopping_server
    @status = 'stopping'
    start_thread {@server.stop}
  end
  
  def start_thread
    Thread.new do
      begin
        yield
      rescue Exception => exception
        @exception = exception
      end
    end
  end
  
  def wait_for_condition
    count = 0
    sleep 1
    while not (result = yield)
      if (@exception)
        error = @exception
        @exception = nil
        @status = 'error'
        raise error
      end
      count = count + 1
      raise 'wait timed out' unless count < 10
      sleep 1
    end
  end

end
end