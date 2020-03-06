require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  # test "the truth" do
  #   assert true
  # end
  test "invalid signup information" do
    get signup_path #not necessary but catches bad mistakes
    assert_no_difference 'User.count' do
     post users_path, params: { user: { name:  "",
                                         email: "user@invalid",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
   assert_template 'users/new'
   assert_select 'div#error_explanation' #line 16 & 17 how detailed do you want your test to be
   assert_select 'div.field_with_errors'
  end
end