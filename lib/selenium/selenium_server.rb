require 'net/http'

module Selenium
class SeleniumServer
  def initialize(cotta, port_number = 4444)
    @cotta = cotta
    @port_number = port_number
  end
  
  def start
    jar = @cotta.file(__FILE__).parent.file('openqa/selenium-server.jar')
    @cotta.shell("java -jar #{jar.path} -port #{@port_number}") {|io| puts io.gets}
  end
  
  def stop
    Net::HTTP.get('localhost', '/selenium-server/driver/?cmd=shutDown', @port_number)
  end
  
  def running?
    url = URI.parse("http://localhost:#{@port_number}/selenium-server/driver/?cmd=testComplete&sessionId=smoketest")
    request = Net::HTTP::Get.new(url.path)
    begin
      res = Net::HTTP.start(url.host, url.port) {|http|
        http.read_timeout=5
        http.request(request)
      }
      puts "response: #{res}"
    rescue Errno::EBADF => e
      return false
    end 
    return true      
  end
end
end