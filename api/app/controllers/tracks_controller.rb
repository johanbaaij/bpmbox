class TracksController < ApplicationController
  include JSONAPI::Errors

  def index
    @collection = Collection.find_by(username: params[:discogs_username])
    render jsonapi: @collection.tracks
  end
end
