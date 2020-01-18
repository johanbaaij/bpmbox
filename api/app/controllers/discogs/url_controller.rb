# frozen_string_literal: true

module Discogs
  class UrlController < ApplicationController
    def redirect
      @api = Discogs::Api.new(current_user)
      api_url = PageUrlConverter.new(params[:url]).to_api_url
      redirect_to api_url
    end
  end
end
