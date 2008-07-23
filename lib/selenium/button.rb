module Selenium
  class Button < HtmlElement
    def click_wait
      webpage.click_wait locator
    end
  end
end