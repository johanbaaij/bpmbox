class ApplicationController < ActionController::API
  respond_to :json
  include DeviseTokenAuth::Concerns::SetUserByToken
end
