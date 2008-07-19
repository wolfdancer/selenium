module Selenium
  class HtmlElement
    attr_reader :webpage, :locator
    def initialize(webpage, locator)
      @webpage, @locator = webpage, locator
    end
  end
end