# frozen_string_literal: true

class TracksController < ApplicationController
  include JSONAPI::Errors
  include JSONAPI::Fetching

  def index
    collection = Collection
                 .find_by!(username: params[:collection_username])

    tracks = collection.tracks
                       .includes(:release)
                       .order('releases.title', 'tracks.position')

    render jsonapi: tracks
  end

  def jsonapi_serializer_params
    {
      username: params[:collection_username]
    }
  end
end
