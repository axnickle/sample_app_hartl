require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest
 
# test "should get home" do
#     get static_pages_home_url
#     assert_response :success
#   end

#   test "should get help" do
#     get static_pages_help_url
#     assert_response :success
#   end

#   test "should get about" do
#     get static_pages_about_url
#     assert_response :success
#   end

#   test "should get contact" do
#     get static_pages_contact_url
#     assert_response :success
#   end
# end

#finally found my testing error. 2/21 - I defined full_title in /sample_app/app/helpers/application_helper.rb
# now when I checked my rails test... it makes sense :)

test "should get home" do
    get root_path #optional conveiton of using the *_path form for each named route
    #get static_pages_home_url
    assert_response :success
    assert_select "title", "Ruby on Rails Tutorial Sample App"
  end

  test "should get help" do
    get help_path #when changed or updated in routes.rb, need to changed this file static_pages_controller.rb
    #get static_pages_help_url
    assert_response :success
    assert_select "title", "Help | Ruby on Rails Tutorial Sample App"
  end

  test "should get about" do
    get about_path
    #get static_pages_about_url
    assert_response :success
    assert_select "title", "About | Ruby on Rails Tutorial Sample App"
  end

  test "should get contact" do
    get contact_path
    #get static_pages_contact_url
    assert_response :success
    assert_select "title", "Contact | Ruby on Rails Tutorial Sample App"
  end
end