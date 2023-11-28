require "test_helper"

class Admin::GistsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @gist = gists(:one)
  end

  test "should get index" do
    get admin_gists_url
    assert_response :success
  end

  test "should get new" do
    get new_admin_gist_url
    assert_response :success
  end

  test "should create gist" do
    assert_difference('Gist.count') do
      post admin_gists_url, params: { gist: { gist_url: @gist.gist_url, question_id: @gist.question_id, user_id: @gist.user_id } }
    end

    assert_redirected_to gist_url(Gist.last)
  end

  test "should show gist" do
    get admin_gist_url(@gist)
    assert_response :success
  end

  test "should get edit" do
    get edit_admin_gist_url(@gist)
    assert_response :success
  end

  test "should update gist" do
    patch admin_gist_url(@gist), params: { gist: { gist_url: @gist.gist_url, question_id: @gist.question_id, user_id: @gist.user_id } }
    assert_redirected_to gist_url(@gist)
  end

  test "should destroy gist" do
    assert_difference('Gist.count', -1) do
      delete admin_gist_url(@gist)
    end

    assert_redirected_to admin_gists_url
  end
end
