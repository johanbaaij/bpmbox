class ReleasesController < ApplicationController
  def show
    @release = Release.find_by_discogs_id(params[:id])
    render jsonapi: @release
  end
end