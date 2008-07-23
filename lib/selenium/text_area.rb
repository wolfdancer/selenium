module Selenium
  class TextArea < HtmlElement
    def enter(value)
      @webpage.enter(@locator, value)
    end

    def value
      @webpage.value(@locator)
    end

    puts "#{__FILE__}:#{__LINE__}"
    p instance_methods.include?("double_click")
  end
end