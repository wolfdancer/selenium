module Selenium
  class TextField < HtmlElement
    def enter(value)
      @webpage.enter(locator, value)
    end

    def value
      @webpage.value(locator)
    end
  end
end