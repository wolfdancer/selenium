require "rubygems"
require "spec"

require File.dirname(__FILE__) + '/../../lib/selenium'

describe 'Time Out Control' do

  it "should honor the time out argument" do
     link_list=["http://www.myantel.net.mm",
               "http://www.khitlunge.net.mm",
               "http://www.mrtv4.net.mm",
               "http://www.mpt.net.mm",
               "http://www.yatanarponteleport.net.mm",
               "http://www.net.mm",
               "http://www.mwdtv.net.mm",
               "http://ns1.net.mm",
               "http://www.isy.net.mm",
               "http://www.mptmail.net.mm",
               "http://www.mrtv3.net.mm"

     ]

     selenium=Selenium::Client::Driver.new("localhost", 4444,"*chrome", link_list.first, 600000)
     selenium.start
     selenium.set_timeout(600000)
     link_list.each {|url| selenium.open(url) }
  end

end
