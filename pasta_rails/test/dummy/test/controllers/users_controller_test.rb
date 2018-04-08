require 'test_helper'

class UsersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:alice)
  end

  test "should get index" do
    get users_url
    assert_response :success
  end

  test "should get new" do
    get new_user_url
    assert_response :success
  end

  test "should create user" do
    assert_difference('User.count') do
      post users_url, params: { user: { name: "Charlie", password: "baseball" } }
    end

    assert_redirected_to user_url(User.last)
  end

  test "should update password on authenticate" do
    @bob = users(:bob)
    digest = @bob.password_digest
    @bob.authenticate "letmein"
    assert_not_equal(@bob.password_digest, digest)
  end

  test "should not update password on incorrect authenticate" do
    digest = @user.password_digest
    @user.authenticate "letmein"
    assert_equal(@user.password_digest, digest)
  end

  test "should show user" do
    get user_url(@user)
    assert_response :success
  end

  test "should auth user" do
    patch user_url(@user), params: { user: { password: "hunter2" } }
    assert_redirected_to user_url(@user)
  end

  test "should destroy user" do
    assert_difference('User.count', -1) do
      delete user_url(@user)
    end

    assert_redirected_to users_url
  end
end
