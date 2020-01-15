# frozen_string_literal: true

class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :provider, :uid, :allow_password_change, :name, :nickname, :image, :email

  attribute :connected_to_discogs do |user|
    user.discogs_user.authenticated?
  end

  attribute :discogs_identity do |user|
    user.discogs_user.get_identity
  rescue StandardError
    nil
  end
end
