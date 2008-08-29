require 'spec'

context 'domain based web testing example' do
  specify 'basic' do
    # START basic
    login_page = LoginPage.new(@browser)
    login_page.username_field.enter('user')
    login_page.password_field.enter('password')
    login_page.login_button.click
    # END basic
  end

  specify 'login' do
    # START login
    login_page = LoginPage.new(@browser)
    login_page.login('user', 'wrongpassword')
    work_items_page = WorkItemsPage.new(@browser)
    work_item_page.fill_in(data_fixture.create_full_work_item_data)
    work_item_page.due_date_field.enter_yesterday
    work_item_page.submit_buttoc.click
    work_item_page.should be_present
    work_item_page.error.should be_visible
    work_item_page.error.text.should == 'Due date should be after today'
    # END login
  end
end

# START check
class CommentCheckBox
  attr_reader :browser, :locator

  def initialize(browser, locator, comment_span)
    @browser = browser
    @locator = locator
    @comment_span = comment_span
  end

  def selected
    browser.get_value(locator) == 'on'
  end

  def click
    old_value = selected
<<<<<<< HEAD:site/doc/example.rb
    browser.wait_for_condition(@comment_span.script_check_visible((not old_value)), 5000)
=======
    browser.wait_for_condition(@comment_span.script_check_visible(not old_value), 5000)
>>>>>>> a3598e23fd3d746137b3a82b575d68ed060b1d4b:site/doc/example.rb
  end
end
# END check
