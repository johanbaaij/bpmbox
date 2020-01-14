# frozen_string_literal: true

class DiscogsController < ApplicationController
  before_action :authenticate_user!

  before_action do
    consumer = OAuth::Consumer.new(Rails.application.credentials.discogs[:key], Rails.application.credentials.discogs[:secret],:site => "https://api.discogs.com")
    access_token = nil
    if current_user.discogs_access_token.present?
      access_token = OAuth::AccessToken.from_hash(consumer, current_user.discogs_access_token.symbolize_keys)
    end
    @discogs = Discogs::Wrapper.new('bpmbox', access_token)
  end

  def index
    # render json: session
  end

  def authenticate
    app_key      = Rails.application.credentials.discogs[:key]
    app_secret   = Rails.application.credentials.discogs[:secret]
    request_data = @discogs.get_request_token(app_key, app_secret,
      'http://localhost:8080/discogs/callback')
      current_user.discogs_request_token = request_data[:request_token].params

    current_user.save
    render json: {
      url: request_data[:authorize_url]
    }
  end

  def callback
    consumer = OAuth::Consumer.new(Rails.application.credentials.discogs[:key], Rails.application.credentials.discogs[:secret],:site => "https://api.discogs.com")
    request_token = OAuth::RequestToken.from_hash(consumer, current_user.discogs_request_token.symbolize_keys)
    verifier      = params[:oauth_verifier]
    access_token  = @discogs.authenticate(request_token, verifier)

    current_user.discogs_request_token = nil
    current_user.discogs_access_token = access_token.params
    current_user.save
    render json: {
      status: "success"
    }
  end
end
