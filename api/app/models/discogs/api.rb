# frozen_string_literal: true

module Discogs
  class Api
    delegate :raw, to: :wrapper

    def initialize(user = nil)
      if user.present?
        @discogs_user = Discogs::User.new(user)
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

    def get_user(username)
      wrapper.get_user(username)
    end

    def get_user_collection(username)
      wrapper.get_user_collection(username, per_page: 100)
    end

    def search(term)
      wrapper.search(term)
    end

    protected

    def wrapper
      @wrapper = Discogs::Wrapper.new('bpmbox/0.1 +https://bpmbox.baaij.com.au', access_token)
    end

    def access_token
      @authenticated ? @discogs_user.access_token : nil
    end
  end
end
