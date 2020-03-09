require 'test_helper'

class UsersLoginTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  
  #A test for user logout (and an improved test for invalid login)
  def setup
    @user = users(:michael)
  end
  
    test "login with valid email/invalid password" do
  get login_path
    assert_template 'sessions/new'
    post login_path, params: { session: { email:    @user.email,
                                          password: "invalid" } }
    assert_not is_logged_in?
 assert_template 'sessions/new'
    assert_not flash.empty?
    get root_path
    assert flash.empty?
  end   
    
  test "login with valid information followed by logout" do
 get login_path
    post login_path, params: { session: { email:    @user.email,
                                          password: 'password' } }
    assert is_logged_in?   
  
  assert_redirected_to @user #to check the right redirect target
    follow_redirect! # and to actually visit the target page
    assert_template 'users/show' # to actually visit the the target page, also verifies that the login link disappears
    assert_select "a[href=?]", login_path, count: 0 # by verifying that there are zero login path links on the page
    assert_select "a[href=?]", logout_path
    assert_select "a[href=?]", user_path(@user)
     delete logout_path
    assert_not is_logged_in?
    assert_redirected_to root_url
    follow_redirect!
    assert_select "a[href=?]", login_path
    assert_select "a[href=?]", logout_path,      count: 0
    assert_select "a[href=?]", user_path(@user), count: 0
  end
end

# testing the case of valid user email, invalid password
# After logging in, we use 'delete' to issue a DELETE request to the logout path and verify that
  # user is logged out and redirected to the root URL.
  # also check the login link reappears and that the logout and proifle links disappear