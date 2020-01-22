# frozen_string_literal: true

class Collection < ApplicationRecord
  belongs_to :user, optional: true
  has_many :collection_releases, autosave: true
  has_many :releases, through: :collection_releases, autosave: true
  validates :username, presence: true
  validate :must_exist_on_discogs

  def discogs_user
    @api = Discogs::Api.new
    @api.get_user(username)
  end

  def must_exist_on_discogs
    user = discogs_user
    if user.resource_url.nil?
      errors.add(:base, :discogs_user_must_exist, message: user.message)
    end
  end
end
