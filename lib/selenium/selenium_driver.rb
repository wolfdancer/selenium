module Selenium
  
  class SeleniumGemCustomizedSeleniumDriver
    extend ::Forwardable
    include WaitFor
    attr_reader :server_host, :server_port, :actual_driver
    
    def initialize(server_host, server_port, browser_string, browser_url, timeout_in_seconds=300)
      @server_host = server_host
      @server_port = server_port
      @browser_string = browser_string
      @browser_url = browser_url
      @timeout = timeout_in_seconds
      @actual_driver = Selenium::Client::Driver.new server_host, server_port, browser_string, browser_url, timeout_in_seconds
    end

    def start
      @actual_driver.start
    end

    def browser_start_command
      @browser_string
    end

    def browser_url
      @browser_url
    end

    def timeout_in_milliseconds
      @timeout * 1000
    end

    def insert_javascript_file(uri)
      js = <<-USEREXTENSIONS
    var headTag = document.getElementsByTagName("head").item(0);
    var scriptTag = document.createElement("script");
    scriptTag.src = "#{uri}";
    headTag.appendChild( scriptTag );
      USEREXTENSIONS
      @actual_driver.get_eval(js)
    end

    #--------- Commands

    # Type text into a page element
    def type(locator, value)
      assert_element_present locator
      @actual_driver.type locator, value
    end

    def click(locator)
      assert_element_present locator
      @actual_driver.click locator
    end

    def select(select_locator, option_locator)
      assert_element_present select_locator
      @actual_driver.select select_locator, option_locator
    end

    # Reload the current page that the browser is on.
    def reload
      @actual_driver.get_eval("selenium.browserbot.getCurrentWindow().location.reload()")
    end

    # Click a link and wait for the page to load.
    def click_and_wait(locator, wait_for = default_timeout)
      click locator
      assert_page_loaded wait_for
    end

    # Click the back button and wait for the page to load.
    def go_back_and_wait
      @actual_driver.go_back
      assert_page_loaded
    end

    # Open the home page of the Application and wait for the page to load.
    def open(url)
      @actual_driver.open url
      assert_page_loaded
    end
    alias_method :open_and_wait, :open

    # Get the inner html of the located element.
    def get_inner_html(locator)
      @actual_driver.get_eval inner_html_js(locator)
    end

    # Does the element at locator not contain the text?
    def element_does_not_contain_text(locator, text)
      return true unless @actual_driver.is_element_present(locator)
      return !element(locator).contains?(text)
    end

    #----- Waiting for conditions
    def assert_element_present(locator, params={})
      params = {
      :message => "Expected element '#{locator}' to be present, but it was not"
      }.merge(params)
      wait_for(params) do
        @actual_driver.is_element_present(locator)
      end
    end

    def assert_element_not_present(locator, params={})
      params = {
      :message => "Expected element '#{locator}' to be absent, but it was not"
      }.merge(params)
      wait_for(:message => params[:message]) do
        !@actual_driver.is_element_present(locator)
      end
    end

    def wait_for_page_to_load(timeout=default_timeout)
      @actual_driver.wait_for_page
      if @actual_driver.get_title.include?("Exception caught")
        raise "We got a new page, but it was an application exception page.\n\n#{@actual_driver.get_html_source}"
      end
    end
    alias_method :assert_page_loaded, :wait_for_page_to_load

    # Open the log window on the browser. This is useful to diagnose issues with Selenium Core.
    def show_log(log_level = "debug")
      @actual_driver.get_eval "LOG.setLogLevelThreshold('#{log_level}')"
    end

    # Slow down each Selenese step after this method is called.
    def slow_mode
      @actual_driver.get_eval "slowMode = true"
      @actual_driver.get_eval 'window.document.getElementsByName("FASTMODE")[0].checked = true'
    end

    # Speeds up each Selenese step to normal speed after this method is called.
    def fast_mode
      @actual_driver.get_eval "slowMode = false"
      @actual_driver.get_eval 'window.document.getElementsByName("FASTMODE")[0].checked = false'
    end

    def inner_html_js(locator)
      %Q|this.page().findElement("#{locator}").innerHTML|
    end
    
    def to_s
      "SeleniumDriver (Modified by selenium gem)"
    end

    unmodified_methods = Selenium::Client::Driver.public_instance_methods - Selenium::SeleniumGemCustomizedSeleniumDriver.public_instance_methods
    unmodified_methods.each do |selenium_api_method|
      def_delegator :@actual_driver, selenium_api_method.to_sym
    end
    # puts unmodified_methods.inspect
    
    # puts Selenium::Client::Driver.public_instance_methods.inspect
    # puts Selenium::SeleniumGemCustomizedSeleniumDriver.public_instance_methods.inspect
    
    # def_delegators :@actual_driver, :stop, :get_confirmation, 
    #                :is_element_present, :get_title, :get_value, :double_click, 
    #                :is_alert_present, :get_alert, :key_press, :context_menu, :focus,
    #                :set_speed, :get_speed, :capture_screenshot, :fire_event, :shit_key_down


    alias_method :confirm, :get_confirmation
  end
  
  SeleniumDriver = SeleniumGemCustomizedSeleniumDriver
  
end
