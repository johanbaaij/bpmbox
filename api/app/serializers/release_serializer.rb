# frozen_string_literal: true

class ReleaseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :artist, :title
  attribute :collection do |_object, params|
    params[:username]
  end

  has_many :tracks
end
