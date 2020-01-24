# frozen_string_literal: true

require 'test_helper'

class ImportSpotifyAudioFeaturesJobTest < ActiveSupport::TestCase
  test 'Gets a bunch of audio features' do
    job = ImportSpotifyAudioFeaturesJob.new
    job.perform(831310)
    release = Release.find_by(discogs_release_id: 831310)
    release.tracks.each do |track|
      assert_not_nil track.bpm
    end
  end
end
