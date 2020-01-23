class AuthController < ApplicationController
  include JSONAPI::Errors
  before_action :authenticate_user!

  def user
    render jsonapi: current_user
  end

  def refresh
    render json: {
      status: "success"
    }
  end
end
