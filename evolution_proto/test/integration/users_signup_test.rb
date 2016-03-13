require 'test_helper'

class UsersSignupTest < ActionDispatch::IntegrationTest
  test "Invalid signup information"  do
  	get register_path
  	assert_no_difference "User.count" do
  	  post users_path, user: {
  	  	name: "",
  	  	email: "foo@invalid",
  	  	password: "foo",
  	  	password_confirmation: "bar"
  	  }
  	end 
  	assert_template "users/new"
  end

  test "Valid signup information" do
  	get register_path
  	assert_difference "User.count", 1 do
  	  post_via_redirect users_path, user: {
  	  	name: "Example User",
  	  	email: "euser@gmail.com",
  	  	password: "foobar",
  	  	password_confirmation: "foobar"
  	  }
  	end
  	assert_template "users/show"
  end
end
