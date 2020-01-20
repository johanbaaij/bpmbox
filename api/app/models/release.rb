# frozen_string_literal: true

class Release < ApplicationRecord
  has_many :tracks, dependent: :nullify
  has_and_belongs_to_many :users
  attr_accessor :discogs_id

  def self.from_discogs_id(resource_id)
    @response = Discogs::Api.new.get_release(resource_id)
    Discogs::Responses::Release.new(@response).to_release
  end
end
