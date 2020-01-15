# frozen_string_literal: true

class Discogs::AuthorizerController < ApplicationController
  before_action :authenticate_user!

  before_action do
    @authenticator = Discogs::Authorizer.new(current_user)
  end

  def authorize
    request_data = @authenticator.get_request_data
    render json: {
      url: request_data[:authorize_url]
    }
  end

  def callback
    @authenticator.get_access_token(params[:oauth_verifier])
    render json: {
      status: "success"
    }
  end
end
