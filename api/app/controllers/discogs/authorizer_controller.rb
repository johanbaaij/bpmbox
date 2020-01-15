# frozen_string_literal: true

module Discogs
  class AuthorizerController < ApplicationController
    before_action :authenticate_user!

    before_action do
      @authorizer = Discogs::Authorizer.new(current_user)
    end

    def authorize
      @authorizer.request_oauth_token_and_url_from_api
      if @authorizer.valid?
        render json: {
          url: @authorizer.url
        }
      else
        render json: {
          error: 'Unable to authorize',
          status: 400
        }, status: 400
      end
    end

    def callback
      @authorizer.authenticate_with_oath_token(params[:oauth_verifier])
      render json: {
        status: 'success'
      }
    end
  end
end
