# frozen_string_literal: true
require 'sidekiq/testing'
require 'test_helper'

class ImportSpotifyAudioFeaturesJobTest < ActiveSupport::TestCase
  test 'Gets a bunch of audio features' do
    @release = releases(:headset)

    job = ImportSpotifyAudioFeaturesJob.new
    job.perform("johanbaaij", @release.discogs_release_id)

    @release.tracks.each do |track|
      assert_not_nil track.bpm
    end
  end
end
