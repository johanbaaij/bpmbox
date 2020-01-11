require 'test_helper'

class ReleasesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @release = releases(:one)
  end

  test "should get index" do
    get releases_url, as: :json
    assert_response :success
  end

  test "should create release" do
    assert_difference('Release.count') do
      post releases_url, params: { release: { artist_id: @release.artist_id, title: @release.title } }, as: :json
    end

    assert_response 201
  end

  test "should show release" do
    get release_url(@release), as: :json
    assert_response :success
  end

  test "should update release" do
    patch release_url(@release), params: { release: { artist_id: @release.artist_id, title: @release.title } }, as: :json
    assert_response 200
  end

  test "should destroy release" do
    assert_difference('Release.count', -1) do
      delete release_url(@release), as: :json
    end

    assert_response 204
  end
end
