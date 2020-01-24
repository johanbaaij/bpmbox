# frozen_string_literal: true

require 'test_helper'
module Discogs
  module Responses
    class ReleaseTest < ActiveSupport::TestCase
      setup do
        api = Discogs::Api.new
        url = 'https://www.discogs.com/Bob-Dylan-Oh-Mercy/release/3905952'
        resource_id = Discogs::PageUrlConverter.new(url).resource_id
        @response = api.get_release(resource_id)
        @oh_mercy = releases(:oh_mercy)
      end

      test 'Response::Release checks if Hashie is argument' do
        assert_raises StandardError do
          Discogs::Responses::Release.new("string")
        end
      end

      test 'Response::Release extracts properties correctly' do
        release_hash = Discogs::Responses::Release.new(@response)
        assert_equal release_hash.artist, "Bob Dylan"
        assert_equal release_hash.title, "Oh Mercy"
      end

      test 'Response::Release returns ::Release' do
        release_hash = Discogs::Responses::Release.new(@response)
        assert release_hash.to_release.class == ::Release
      end

      test 'Response::Release to_release has correct properties' do
        release_hash = Discogs::Responses::Release.new(@response)
        release = release_hash.to_release
        assert_equal release.title, @oh_mercy.title
        assert_equal release.artist, @oh_mercy.artist
        assert release.tracks.length == 10
      end

    end
  end
end
