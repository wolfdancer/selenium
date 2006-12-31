module Selenium
module Menu
  def home_link
    # todo there should be a way to alter this instance so that the click returns the directory listing page
    Link.by_id(browser, 'home')
  end
  
#MENU START
  def download_link
    Link.by_text(browser, 'Download')
  end
  
  def license_link
    Link.by_text(browser, 'License')
  end
#MENU END
end
end