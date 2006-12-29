require 'net/http'

module Selenium
class SeleniumServer
  def initialize(cotta)
    @cotta = cotta
  end
  
  def start
    jar = @cotta.file(__FILE__).parent.file('openqa/selenium-server.jar')
    @cotta.shell("java -jar #{jar.path}") {|io| puts io.gets}
  end
  
  def stop
    Net::HTTP.get('localhost', '/selenium-server/driver/?cmd=shutDown', 4444)
  end
  
  def running?
    begin
      value = Net::HTTP.get('localhost', '/selenium-server/driver/?cmd=testComplete&sessionId=smoketest', 4444)
      puts "value got: #{value}"
      return true
    rescue Exception => e
      puts e
    end
    return false
  end
end
end