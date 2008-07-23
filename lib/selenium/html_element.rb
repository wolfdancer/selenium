module Selenium
  class HtmlElement
    attr_reader :webpage, :locator
    def initialize(webpage, locator)
      @webpage, @locator = webpage, locator
    end

    def double_click
      webpage.double_click locator
    end

    def key_press(key)
      webpage.key_press locator, key
    end
  end
end