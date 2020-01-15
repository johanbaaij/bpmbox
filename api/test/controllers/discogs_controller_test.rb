# frozen_string_literal: true

require 'test_helper'

class DiscogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resource = users(:no_discogs)
  end

  test 'should return url when logged in' do
    new_auth_header = @resource.create_new_auth_token
    get '/discogs/authorize', headers: new_auth_header, xhr: true
    assert_response :success
    authorize_response = JSON.parse(@response.body)
    assert_not_nil authorize_response['url']
  end
end
