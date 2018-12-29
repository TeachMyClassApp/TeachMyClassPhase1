require 'test_helper'

class LessonControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get lesson_index_url
    assert_response :success
  end

  test "should get new" do
    get lesson_new_url
    assert_response :success
  end

  test "should get create" do
    get lesson_create_url
    assert_response :success
  end

  test "should get listing" do
    get lesson_listing_url
    assert_response :success
  end

  test "should get pricing" do
    get lesson_pricing_url
    assert_response :success
  end

  test "should get description" do
    get lesson_description_url
    assert_response :success
  end

  test "should get photo_upload" do
    get lesson_photo_upload_url
    assert_response :success
  end

  test "should get features" do
    get lesson_features_url
    assert_response :success
  end

  test "should get location" do
    get lesson_location_url
    assert_response :success
  end

  test "should get update" do
    get lesson_update_url
    assert_response :success
  end

end
