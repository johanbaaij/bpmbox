# frozen_string_literal: true

class TracksController < ApplicationController
  include JSONAPI::Errors
  include JSONAPI::Fetching
  include JSONAPI::Pagination
  include JSONAPI::Filtering

  ALLOWED_RANSACK_FIELDS = %w[
    bpm_nulls_last
    key_nulls_last
    r_title_positions
    r_artist_positions
    title
  ].freeze

  def index
    tracks = Collection
             .find_by!(username: params[:collection_username]).tracks

    jsonapi_filter(tracks, ALLOWED_RANSACK_FIELDS) do |filtered|
      filtered.sorts = 'r_title_positions asc' if filtered.sorts.empty?

      jsonapi_paginate(filtered.result) do |paginated|
        render jsonapi: paginated
      end
    end
  end

  private

  def jsonapi_serializer_params
    {
      username: params[:collection_username]
    }
  end

  def jsonapi_meta(resources)
    pagination = jsonapi_pagination_meta(resources)
    return unless pagination.present?

    { pagination: pagination, total: resources.unscoped.count }
  end
end
