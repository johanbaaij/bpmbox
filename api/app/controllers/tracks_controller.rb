# frozen_string_literal: true

class TracksController < ApplicationController
  include JSONAPI::Errors

  def index
    @collection = Collection
                  .find_by(username: params[:collection_username])
    render jsonapi: @collection.tracks
                               .joins(:release)
                               .order('releases.title', 'tracks.position')
  end
end
