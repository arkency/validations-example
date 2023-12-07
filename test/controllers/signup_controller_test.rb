require "test_helper"

class SignupControllerTest < ActionDispatch::IntegrationTest
  test "should render signup form with no issues" do
    get signups_path

    assert_response :success
  end

  test "should redirect after successful creation" do
    post signups_path, params: { signup: { email: "joe@example.com", password: "password" } }

    assert_redirected_to signups_path
  end

  test "should render signup form with errors" do
    post signups_path, params: { signup: { email: "joe@example.com", password: "pass" } }

    assert_response :unprocessable_entity
  end

  test "don't allow to create user with the same email" do
    post signups_path, params: { signup: { email: "joe@example.com", password: "password" } }
    post signups_path, params: { signup: { email: "joe@example.com", password: "password" } }

    assert_response :unprocessable_entity
  end
end
