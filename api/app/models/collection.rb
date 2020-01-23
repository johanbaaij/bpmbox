# frozen_string_literal: true

class Collection < ApplicationRecord
  belongs_to :user, optional: true
  has_many :collection_releases, autosave: true
  has_many :releases, through: :collection_releases, autosave: true
  has_many :tracks, through: :releases, autosave: true
  validates :username, presence: true
  validate :must_exist_on_discogs

  def add_releases_from_api(hashes)
    hashes.each do |hash|

      next if in_collection?(hash.instance_id)

      release = releases
                .find_by(discogs_release_id: hash.id)

      unless release.present?
        release = Discogs::Responses::Release
                  .new(hash.basic_information)
                  .to_release
      end

      collection_releases << CollectionRelease.new(
        discogs_instance_id: hash.instance_id,
        release: release
      )
    end
  end

  def must_exist_on_discogs
    if Discogs::Api.new.get_user(username).resource_url.nil?
      errors.add(:base, :discogs_user_must_exist, message: user.message)
    end
  end

  def in_collection?(instance_id)
    collection_releases
      .find_by(discogs_instance_id: instance_id)
  end
end
