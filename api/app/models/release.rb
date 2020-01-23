# frozen_string_literal: true

class Release < ApplicationRecord
  has_many :tracks, dependent: :nullify, autosave: true
  has_and_belongs_to_many :users
  has_many :collections, through: :collection_releases
  has_many :collection_releases

  after_create :fetch_tracks

  def fetch_tracks
    ImportDiscogsReleaseJob.perform_async(discogs_release_id)
  end
end
