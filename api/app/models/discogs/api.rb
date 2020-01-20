# frozen_string_literal: true

module Discogs
  class Api
    def initialize(user = nil)
      if user.present?
        @discogs_user = DiscogsUser.new(user)
        @authenticated = @discogs_user.authenticated?
      else
        @authenticated = false
      end
    end

    def get_release(discogs_id)
      Rails.cache.fetch("release/#{discogs_id}") do
        wrapper.get_release(discogs_id)
      end
    end

    protected

    def wrapper
      @wrapper = Discogs::Wrapper.new('bpmbox', access_token)
    end

    def access_token
      @authenticated ? @discogs_user.access_token : nil
    end
  end
end
