# frozen_string_literal: true

module Discogs
  class User
    def initialize(user)
      @user = user
      @wrapper = Discogs::Wrapper.new('bpmbox', access_token)
    end

    def authenticated?
      @wrapper.get_identity
      @wrapper.authenticated?
    rescue StandardError
      false
    end

    def store_request_token(token)
      @user.update(discogs_request_token: token.params)
    end

    def request_token
      OAuth::RequestToken.from_hash(
        consumer,
        @user.discogs_request_token.symbolize_keys
      )
    end

    def store_access_token(token)
      @user.update(
        discogs_request_token: nil,
        discogs_access_token: token.params
      )
    end

    def access_token
      if @user.discogs_access_token.present?
        OAuth::AccessToken.from_hash(
          consumer,
          @user.discogs_access_token.symbolize_keys
        )
      end
    end

    protected

    def consumer
      OAuth::Consumer.new(
        Rails.application.credentials.discogs[:key],
        Rails.application.credentials.discogs[:secret],
        site: 'https://api.discogs.com'
      )
    end
  end
end
