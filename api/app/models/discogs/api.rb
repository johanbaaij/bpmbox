module Discogs
  class Api
    delegate :raw, to: :wrapper
    delegate :get_release, to: :wrapper

    def initialize(user=nil)
      if user.present?
        @discogs_user = DiscogsUser.new(user)
        @authenticated = @discogs_user.authenticated?
      else
        @authenticated = false
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