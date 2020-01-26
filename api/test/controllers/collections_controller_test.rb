# frozen_string_literal: true

require 'test_helper'

class CollectionsControllerTest < ActionDispatch::IntegrationTest
  test 'discogs_lookup for invalid user returns error' do
    get collection_path(username: 'adsadasdasdasfggg33333'), as: :json
    assert_equal 200, response.status
    assert_not_empty response.parsed_body["message"]
  end

  test 'discogs_lookup for valid user returns resource_url and num_collection' do
    get collection_path(username: 'johanbaaij'), as: :json
    assert_equal 200, response.status
    assert_not_empty response.parsed_body['resource_url']
    assert_not_nil response.parsed_body['num_collection']
  end
end
