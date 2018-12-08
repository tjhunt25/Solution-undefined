require 'test_helper'

class TestPairsControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get test_pairs_create_url
    assert_response :success
  end

  test "should get update" do
    get test_pairs_update_url
    assert_response :success
  end

  test "should get new" do
    get test_pairs_new_url
    assert_response :success
  end

  test "should get edit" do
    get test_pairs_edit_url
    assert_response :success
  end

  test "should get index" do
    get test_pairs_index_url
    assert_response :success
  end

  test "should get destroy" do
    get test_pairs_destroy_url
    assert_response :success
  end

  test "should get show" do
    get test_pairs_show_url
    assert_response :success
  end

end
