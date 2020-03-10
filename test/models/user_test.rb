require 'test_helper'

class UserTest < ActiveSupport::TestCase

    def setup
      @user = User.new(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar")
    end

    test "should be valid" do
      #assert true
      assert @user.valid? #is this user valid?
    end    
    
    test "name should be present" do
      @user.name = ""     #we want someone to be able to register on the site - have a name
      assert_not @user.valid?  #blank username, not valid user
    end
    
    test "email should be present" do
      @user.email = "    "     #we want someone to be able to register on the site
      assert_not @user.valid? #assert not = make sure - user is NOT valid
    end
  
    test "name should not be too long" do
      @user.name = "a" * 51 # 51- a's
      assert_not @user.valid? #if there's more than 50 a's
    end
    
    test "email should not be too long" do
      @user.email = "a" * 244 + "@example.com" #less check that there's less than less 256 characters - limit
      assert_not @user.valid?
    end
    
    test "email validation should accept valid addresses" do
      valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                           first.last@foo.jp alice+bob@baz.cn]
      valid_addresses.each do |valid_address|
        @user.email = valid_address
        assert @user.valid?, "#{valid_address.inspect} should be valid"
      end
    end
    
    test "email validation should reject invalid addresses" do
      invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                             foo@bar_baz.com foo@bar+baz.com]
      invalid_addresses.each do |invalid_address|
        @user.email = invalid_address
        assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
      end
    end
    
   test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end
end


#if we just one to run 1 test, the model test - bundle exec rake test:models
  #or we can just run rails test:models
#user.dup makes a copy of the values; not the same user