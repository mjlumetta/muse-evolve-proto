require 'test_helper'

class UserTest < ActiveSupport::TestCase
  # test "the truth" do
  #   assert true
  # end

  def setup
  	@user = User.new(name: "Mike Lumetta", email: "mjl@gmail.com",
  		password: "foobar", password_confirmation: "foobar")
  end

  test "Should be valid" do
  	assert @user.valid?
  end

  test "Name should be present" do
  	@user.name = ""
  	assert_not @user.valid?
  end

  test "Email should be present" do
  	@user.email = ""
  	assert_not @user.valid?
  end

  test "Name should not be too long" do
  	@user.name = "a" * 51
  	assert_not @user.valid?
  end

  test "Email should not be too long" do
  	@user.email = "a" * 241 + "@gmail.com"
  	assert_not @user.valid?
  end

  test "Email should be correctly formatted" do
  	valid_addresses = %w[user@example.com USER@foo.COM A_US-ER@foo.bar.org
                         first.last@foo.jp alice+bob@baz.cn]
    valid_addresses.each do |address|
      @user.email = address
      assert @user.valid?, "#{address.inspect} should be valid"
    end
  end

  test "Invalid email should make user invalid" do
  	invalid_addresses = %w[user@example,com user_at_foo.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com foo@bar..com]
    invalid_addresses.each do |address|
      @user.email = address
      assert_not @user.valid?, "#{address.inspect} should be invalid"
    end
  end

  test "User should have a unique email" do
    duplicate_user = @user.dup 
    @user.save
    assert_not duplicate_user.valid?
  end

  test "Emails should be case-insensitive" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.upcase
    @user.save
    assert_not duplicate_user.valid?
  end

  test "Emails on database should be lowercase" do
    mixed_case_email = "FOO@Example.cOm"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end

  test "Password should not be whitespace" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "Password must be at least the minimum length" do
  	@user.password = @user.password_confirmation = "a" * 5
  	assert_not @user.valid?
  end
end
