require File.join(File.dirname(__FILE__), "spec_helper")

module Selenium

  describe SeleniumDriver do
    it_should_behave_like "Selenium"
    attr_reader :driver, :commands

    before do
      @driver = SeleniumDriver.new("localhost", 4444, "*firefox", "http://localhost:3000", 240)
    end

    describe "#initialize" do

      it "initializes with defaults" do
        driver.server_host.should == "localhost"
        driver.server_port.should == 4444
        driver.browser_start_command.should == "*firefox"
        driver.browser_url.should == "http://localhost:3000"
        driver.timeout_in_milliseconds.should == 240000
      end
    
    end
    
    describe "#inner_html_js" do
      it "returns findElement command in js" do
        driver.inner_html_js(sample_locator).should ==
          %Q|this.page().findElement("#{sample_locator}").innerHTML|
      end
    end
    
    describe "#open and #open_and_wait" do

      it "opens page and waits for it to load" do
        mock(driver.actual_driver).open("http://localhost:4000")
        mock(driver).assert_page_loaded
      
        driver.open("http://localhost:4000")
      end
      
      it "aliases #open_and_wait to #open" do
        driver.method(:open_and_wait).should == driver.method(:open)
      end

    end
      
    describe "#type" do
	
      it "types when element is present and types" do
        is_element_present_results = [false, true]
        mock(driver.actual_driver).is_element_present("id=foobar").once do
          result(is_element_present_results.shift)
        end
        mock(driver.actual_driver).type("id=foobar", "The Text") { result() }
      
        driver.type "id=foobar", "The Text"
      end
      
       it "fails when element is not present" do
         mock(driver).assert_element_present("id=foobar").once do
           flunk("simulated timeout")
         end
         dont_allow(driver.actual_driver).type("id=foobar", "The Text")

         proc do
           driver.type "id=foobar", "The Text"
         end.should raise_error
       end
    end
      
    describe "#click" do
      it "click when element is present and types" do
        is_element_present_results = [false, true]
        mock(driver.actual_driver).is_element_present("id=foobar").once do
          result(is_element_present_results.shift)
        end
        mock(driver.actual_driver).click("id=foobar") {result}
      
        driver.click "id=foobar"
      end
      
      it "fails when element is not present" do
        is_element_present_results = [false, false, false, false]
        mock(driver).assert_element_present("id=foobar").once do
          flunk("simulated timeout")
        end
        dont_allow(driver.actual_driver).click
      
        proc do
          driver.click "id=foobar"
        end.should raise_error
      end
    end
      
    describe "#select" do

      it "types when element is present and types" do
        is_element_present_results = [false, true]
        mock(driver.actual_driver).is_element_present("id=foobar").once do
          result is_element_present_results.shift
        end
        mock(driver.actual_driver).select("id=foobar", "value=3") {result}
      
        driver.select "id=foobar", "value=3"
      end
      
       it "fails when element is not present" do
         mock(driver).assert_element_present("id=foobar").once do
           flunk("simulated timeout")
         end
         dont_allow(driver.actual_driver).select("id=foobar", "value=3")

         proc {
           driver.select "id=foobar", "value=3"
         }.should raise_error
       end
    end
  
    describe "#click" do
      it "click when element is present and types" do
        is_element_present_results = [false, true]
        mock(driver.actual_driver).is_element_present("id=foobar").once do
          result is_element_present_results.shift
        end
        mock(driver.actual_driver).click("id=foobar") {result}
      
        driver.click "id=foobar"
      end
      
      it "fails when element is not present" do
        mock(driver).assert_element_present("id=foobar")  do
          flunk("simulated timeout")
        end
        
        dont_allow(driver.actual_driver).click("id=foobar")
        
        proc do
          driver.click "id=foobar"
        end.should raise_error
      end
    end
    
    def sample_locator
      "sample_locator"
    end

    def sample_text
      "test text"
    end

  end

end
