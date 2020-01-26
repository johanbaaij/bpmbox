class CollectionsController < ApplicationController
  def show
    @collection = Collection.find_or_initialize_by(username: params[:username])
    render jsonapi: @collection
  end

  def import
    @collection = Collection.find_or_create_by(username: params[:username])

    ImportDiscogsCollectionPageJob
      .perform_async(
        "https://api.discogs.com/users/#{params[:username]}/collection/folders/0/releases?per_page=500",
        params[:username]
      )

    render json: {}, status: :ok
  end
end
