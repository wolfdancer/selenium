module Selenium
  class TextArea < HtmlElement
    def enter(value)
      @webpage.enter(@locator, value)
    end

    def value
      @webpage.value(@locator)
    end
  end
end