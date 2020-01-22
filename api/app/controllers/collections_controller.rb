class CollectionsController < ApplicationController
  def new
    @collection = Collection.new(username: params[:username])
    user_details = @collection.discogs_user
    render json: user_details
  end

  def import
    render json: ImportDiscogsCollectionJob.perform_later(params[:username])
  end
end
