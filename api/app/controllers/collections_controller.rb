class CollectionsController < ApplicationController
  def discogs_lookup
    @collection = Collection.find_or_initialize_by(username: params[:username])
    user_details = @collection.discogs_user
    render json: user_details
  end

  def import
    ImportDiscogsCollectionPageJob
      .perform_async(
        "https://api.discogs.com/users/#{params[:username]}/collection/folders/0/releases?per_page=500",
        params[:username]
      )

    render json: {}, status: :ok
  end
end