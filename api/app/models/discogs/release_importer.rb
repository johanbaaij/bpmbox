# frozen_string_literal: true

module Discogs
  class ReleaseImporter
    include ActiveModel::Validations
    delegate :request_token, :access_token, to: :@discogs_user
    validate :discogs_user_can_only_authorize_once

    def initialize(user)
      @user = user
      @discogs_user = Discogs::User.new(user)
      @wrapper = Discogs::Wrapper.new('bpmbox', access_token)
    end

    def import
      collection = @wrapper.get_user_collection(@wrapper.get_identity.username)
      collection.releases.each do |release_hash|
        @discogs_release = Discogs::Responses::Release.new(release_hash.basic_information)
        @release = @discogs_release.to_release
        @user.releases << @release
        @user.save
      end
    end

  end
end
