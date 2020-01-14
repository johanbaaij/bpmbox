# frozen_string_literal: true

class DiscogsController < ApplicationController
  before_action :authenticate_user!

  before_action do
    @discogs = current_user.discogs_api
  end

  def authenticate
    request_data = @discogs.get_request_data
    render json: {
      url: request_data[:authorize_url]
    }
  end

  def callback
    @discogs.get_access_token(params[:oauth_verifier])
    render json: {
      status: "success"
    }
  end
end
