module Selenium
module Locator
  def by_name(name)
    name
  end
  
  def by_id(id)
    "id=#{id}"
  end
  
  def by_text(text)
    "link=#{text}"
  end
end
end