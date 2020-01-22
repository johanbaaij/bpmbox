# frozen_string_literal: true

module Discogs
  class CollectionImporter
    include ActiveModel::Validations
    validate :target_collection_must_be_valid

    attr_reader :releases
    attr_reader :collection

    def initialize(discogs_username)
      @username = discogs_username
      @collection = Collection.find_or_initialize_by(
        username: @username
      )
      @api = Discogs::Api.new
      @releases = []
    end

    def import
      fetch_releases
      sync_releases
      @collection.save
    end

    def fetch_releases
      response = @api.get_user_collection(@username)
      @releases += response.releases

      handle_next_page(response)
    end

    def sync_releases
      new_ids = []

      @releases.each_with_index do |hash, _index|
        release = Discogs::Responses::Release.new(hash.basic_information).to_release

        if @collection.collection_releases.find_by(discogs_instance_id: hash.instance_id)
          next
        end

        @collection.collection_releases << CollectionRelease.new(
          discogs_instance_id: hash.instance_id,
          release: release
        )

        new_ids << release.id
      end
  end

    protected

    def handle_next_page(response)
      next_page = response.pagination.urls.next
      if next_page
        response = @api.raw(next_page)
        @releases += response.releases
        handle_next_page(response)
      else
        @releases
      end
    end

    def target_collection_must_be_valid
      unless @collection.valid?
        errors.add(:base, :target_collection_must_be_valid, message: 'Target collection is invalid')
      end
    end
  end
end
