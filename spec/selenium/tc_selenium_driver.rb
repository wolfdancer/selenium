require File.join(File.dirname(__FILE__), "spec_helper")

module Selenium
  describe SeleniumDriver do
    it_should_behave_like "Selenium"
    attr_reader :driver, :commands
    before do
      @driver = SeleniumDriver.new("localhost", 4444, "*firefox", "http://localhost:3000", 240)
    end

    def sample_locator
      "sample_locator"
    end

    def sample_text
      "test text"
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
        mock(driver).remote_control_command("open", ["http://localhost:4000"])
        mock(driver).remote_control_command("waitForPageToLoad", [driver.default_timeout]) {result}
        mock(driver).remote_control_command("getTitle", []) {result("Some Title")}
      
        driver.open("http://localhost:4000")
      end
      
      it "aliases #open_and_wait to #open" do
        driver.method(:open_and_wait).should == driver.method(:open)
      end
    end
      
    describe "#type" do
	
      it "types when element is present and types" do
        is_element_present_results = [false, true]
        mock(driver).boolean_command("isElementPresent", ["id=foobar"]).once do
          result(is_element_present_results.shift)
        end
        mock(driver).remote_control_command("type", ["id=foobar", "The Text"]) do
          result()
        end
      
        driver.type "id=foobar", "The Text"
      end
      
       it "fails when element is not present" do
         mock(driver).boolean_command("isElementPresent", ["id=foobar"]).once do
           result(false)
         end
         dont_allow(driver).remote_control_command("type", ["id=foobar", "The Text"])

         proc {
           driver.type "id=foobar", "The Text"
         }.should raise_error
       end
    end
      
    describe "#click" do
      it "click when element is present and types" do
        is_element_present_results = [false, true]
        mock(driver).boolean_command("isElementPresent", ["id=foobar"]).once do
          result(is_element_present_results.shift)
        end
        mock(driver).remote_control_command("click", ["id=foobar"]) {result}
      
        driver.click "id=foobar"
      end
      
      it "fails when element is not present" do
        is_element_present_results = [false, false, false, false]
        mock(driver).boolean_command("isElementPresent", ["id=foobar"]).once do
          result(is_element_present_results.shift)
        end
        dont_allow(driver).remote_control_command("click", [])
      
        proc {
          driver.click "id=foobar"
        }.should raise_error
      end
    end
      
    describe "#select" do
      it "types when element is present and types" do
        is_element_present_results = [false, true]
        mock(driver).boolean_command("isElementPresent", ["id=foobar"]).once do
          result is_element_present_results.shift
        end
        mock(driver).remote_control_command("select", ["id=foobar", "value=3"]) {result}
      
        driver.select "id=foobar", "value=3"
      end
      
       it "fails when element is not present" do
         mock(driver).boolean_command("isElementPresent", ["id=foobar"]).once do
           result false
         end
         dont_allow(driver).remote_control_command("select", ["id=foobar", "value=3"])

         proc {
           driver.select "id=foobar", "value=3"
         }.should raise_error
       end
    end
  
    describe "#click" do
      it "click when element is present and types" do
        is_element_present_results = [false, true]
        mock(driver).boolean_command("isElementPresent", ["id=foobar"]).once do
          result is_element_present_results.shift
        end
        mock(driver).remote_control_command("click", ["id=foobar"]) {result}
      
        driver.click "id=foobar"
      end
      
      it "fails when element is not present" do
        is_element_present_results = [false, false, false, false]
        mock(driver).is_element_present("id=foobar").times(4) do
          is_element_present_results.shift
        end
        dont_allow(driver).remote_control_command("click", ["id=foobar"])
        
        proc {
          driver.click "id=foobar"
        }.should raise_error
      end
    end
  end

end
