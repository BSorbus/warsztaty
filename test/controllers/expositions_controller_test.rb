require 'test_helper'

class ExpositionsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @exposition = expositions(:one)
  end

  test "should get index" do
    get expositions_url
    assert_response :success
  end

  test "should get new" do
    get new_exposition_url
    assert_response :success
  end

  test "should create exposition" do
    assert_difference('Exposition.count') do
      post expositions_url, params: { exposition: { name: @exposition.name, user_id: @exposition.user_id } }
    end

    assert_redirected_to exposition_url(Exposition.last)
  end

  test "should show exposition" do
    get exposition_url(@exposition)
    assert_response :success
  end

  test "should get edit" do
    get edit_exposition_url(@exposition)
    assert_response :success
  end

  test "should update exposition" do
    patch exposition_url(@exposition), params: { exposition: { name: @exposition.name, user_id: @exposition.user_id } }
    assert_redirected_to exposition_url(@exposition)
  end

  test "should destroy exposition" do
    assert_difference('Exposition.count', -1) do
      delete exposition_url(@exposition)
    end

    assert_redirected_to expositions_url
  end
end
