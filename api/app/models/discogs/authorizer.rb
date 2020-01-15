# frozen_string_literal: true

module Discogs
  class Authorizer
    include ActiveModel::Validations
    attr_reader :url
    delegate :request_token, :access_token, to: :@discogs_user
    validate :discogs_user_can_only_authorize_once

    def initialize(user)
      @user = user
      @discogs_user = Discogs::User.new(user)
      @wrapper = Discogs::Wrapper.new('bpmbox', access_token)
    end

    def request_oauth_token_and_url_from_api
      request_data = fetch_request_data
      @discogs_user.store_request_token(request_data[:request_token])
      @url = request_data[:authorize_url]
    end

    def authenticate_with_oath_token(verifier)
      access_token = @wrapper.authenticate(request_token, verifier)
      @discogs_user.store_access_token(access_token)
    end

    protected

    def discogs_user_can_only_authorize_once
      if @discogs_user.authenticated? === true
        errors.add(:base, :discogs_user_can_only_authorize_once, message: 'Already authorized')
      end
    end

    def fetch_request_data
      @wrapper.get_request_token(
        Rails.application.credentials.discogs[:key],
        Rails.application.credentials.discogs[:secret],
        "#{Rails.configuration.settings['client_url']}/discogs/callback"
      )
    end
  end
end
