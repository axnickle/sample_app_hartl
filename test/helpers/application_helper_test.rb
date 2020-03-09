require 'test_helper'

class ApplicationHelperTest < ActionView::TestCase
  # test "full title helper" do
  #   assert_equal full_title,         FILL_IN
  #   assert_equal full_title("Help"), FILL_IN
  # end

  test "should get new" do
    gets login_path
    assert_response :success
  end
end

#It's convenient to use the full_title hleper in the tests by including the Application helper into
  #test helper. Can then test for the right title using code such as line 12 & 13 in site_layout_test.rb.
  #although any typo in the base title won't be causght by the test suite. this problem can be fixing by
  #writing a direct test of the full_title helper, which involves creating a file to test the application
  #helper and then filling in the code inidcated with FILL_IN in line 5 & 6 of application_helper_test.rb 
  