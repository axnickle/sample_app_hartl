require 'test_helper'

class SiteLayoutTest < ActionDispatch::IntegrationTest
  
  test "layout links" do
    get root_path
    assert_template 'static_pages/home'
    assert_select "a[href=?]", root_path, count: 2 #root_path is inserted into the ? in href; testing the href tag
    assert_select "a[href=?]", help_path #using? handles escape uatomatically 
    assert_select "a[href=?]", about_path #rails inserts about_path in place of question mark, checking for an HTML tag of the form
    assert_select "a[href=?]", contact_path
    user = users(:michael)
    log_in_as(user)
    get root_path
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", users_path
    assert_select "a[href=?]", user_path(user)
    assert_select "a[href=?]", edit_user_path(user)
  end                                    
end

#assert_select method, we use a syntax that allow us to test for the presence of a 
#particular link-URL combination by specifiying the tag name  and attribute href
#count: 2 means there are 2 such link - one each for the logo and navigation menu element
#line 8 is linking to root_path in _header.html.erb line 4