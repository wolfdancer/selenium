require 'net/http'

module Selenium
class SeleniumServer
  def SeleniumServer::run(argv)
    jar_file = SeleniumServer.jar_file
    command = "java -jar #{jar_file} #{argv.join(' ')}"
    puts command
    system(command)
  end
  
  def SeleniumServer::jar_file
    File.join(File.dirname(__FILE__), 'openqa', 'selenium-server.jar.txt')
  end
  
  attr_reader :port_number

  def initialize(port_number = 4444)
    @port_number = port_number
  end
  
  def start
    SeleniumServer.run(['-port', port_number.to_s])
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