# frozen_string_literal: true

module Overrides
  module DeviseTokenAuth
    class SessionsController < ::DeviseTokenAuth::SessionsController
      include JSONAPI::Errors

      # Prevent session parameter from being passed
      # Unpermitted parameter: session
      wrap_parameters format: []

      def render_create_success
        render jsonapi: @resource
      end
    end
  end
end
