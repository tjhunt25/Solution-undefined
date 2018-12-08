require 'test_helper'

class ShowControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get show_index_url
    assert_response :success
  end

  test "should get edit" do
    get show_edit_url
    assert_response :success
  end

  test "should get update" do
    get show_update_url
    assert_response :success
  end

  test "should get destroy" do
    get show_destroy_url
    assert_response :success
  end

end
