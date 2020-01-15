# frozen_string_literal: true

require 'test_helper'
module Discogs
  class AuthorizerTest < ActiveSupport::TestCase
    setup do
      @user = users(:no_discogs)
      @user_connected_to_discogs = users(:authorized_discogs)
    end

    test 'User not connected with Discogs can request authorization URL' do
      authorizer = Discogs::Authorizer.new(@user)
      authorizer.request_oauth_token_and_url_from_api
      assert_not_nil authorizer.url
    end

    test 'User not connected with Discogs gets request token' do
      authorizer = Discogs::Authorizer.new(@user)
      discogs_user = Discogs::User.new(@user)
      authorizer.request_oauth_token_and_url_from_api
      assert_not_nil @user.discogs_request_token
      assert_not_nil discogs_user.request_token
    end

    test 'User already connected with Discogs results in invalid' do
      authorizer = Discogs::Authorizer.new(@user_connected_to_discogs)
      assert_not authorizer.valid?
    end
  end
end
