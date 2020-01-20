class ReleasesController < ApplicationController
  include JSONAPI::Fetching
  def show
    @release = Release.from_discogs_id(params[:discogs_id])
    render jsonapi: @release
  end
end