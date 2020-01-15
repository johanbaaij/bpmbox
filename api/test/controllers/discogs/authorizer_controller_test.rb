# frozen_string_literal: true

require 'test_helper'

class DiscogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:no_discogs)
    @user_connected_to_discogs = users(:authorized_discogs)
  end

  test 'should return url if not authorized yet' do
    new_auth_header = @user.create_new_auth_token
    get '/discogs/authorize', headers: new_auth_header, xhr: true
    assert_response :success
    authorize_response = JSON.parse(@response.body)
    assert_not_nil authorize_response['url']
  end

  test 'should result in error if authorized' do
    new_auth_header = @user_connected_to_discogs.create_new_auth_token
    get '/discogs/authorize', headers: new_auth_header, xhr: true
    assert_response :bad_request
  end
end
