module Selenium
class TextField < HtmlElement
  attr_reader :browser
  
  def initialize(webpage, locator)
    super(webpage, locator)
  end
  
  def enter(value)
    @webpage.type(@locator, value)
  end
  
  def value
    @webpage.value(@locator)
  end
end
end