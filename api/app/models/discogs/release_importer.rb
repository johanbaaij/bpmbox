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
      collection.releases.each do |release|
        @artist = Artist.create(name: release.basic_information.artists.pluck("name").join(release.basic_information.artists.join))
        @release = Release.create(title: release.basic_information.title, artist: @artist)
        @user.releases << @release
        @user.save
      end
    end

  end
end
