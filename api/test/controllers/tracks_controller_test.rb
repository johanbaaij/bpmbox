require 'test_helper'

class TracksControllerTest < ActionDispatch::IntegrationTest
  setup do
    @track = tracks(:one)
  end

  test "should get index" do
    get tracks_url, as: :json
    assert_response :success
  end

  test "should create track" do
    assert_difference('Track.count') do
      post tracks_url, params: { track: { artist_id: @track.artist_id, bpm: @track.bpm, key: @track.key, release_id: @track.release_id, side: @track.side, title: @track.title, track: @track.track } }, as: :json
    end

    assert_response 201
  end

  test "should show track" do
    get track_url(@track), as: :json
    assert_response :success
  end

  test "should update track" do
    patch track_url(@track), params: { track: { artist_id: @track.artist_id, bpm: @track.bpm, key: @track.key, release_id: @track.release_id, side: @track.side, title: @track.title, track: @track.track } }, as: :json
    assert_response 200
  end

  test "should destroy track" do
    assert_difference('Track.count', -1) do
      delete track_url(@track), as: :json
    end

    assert_response 204
  end
end
