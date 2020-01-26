# frozen_string_literal: true

class ReleasesController < ApplicationController
  # include JSONAPI::Errors
  include JSONAPI::Fetching

  def index
    collection = Collection
                 .find_by!(username: params[:collection_username])
    render jsonapi: collection.releases
  end

  def show
    @release = Release
               .includes(:tracks).find_by!(discogs_release_id: params[:id])
    render jsonapi: @release
  end

  def jsonapi_serializer_params
    {
      username: params[:collection_username]
    }
  end
end
