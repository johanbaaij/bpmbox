require 'test_helper'

class DiscogsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @resource = users(:johan)
  end

  test 'should return url when logged in' do
    new_auth_header = @resource.create_new_auth_token
    get '/discogs/authenticate', headers: new_auth_header, xhr: true
    assert_response :success
    authenticate_response = JSON.parse(@response.body)
    assert_not_nil authenticate_response["url"]
  end
end
