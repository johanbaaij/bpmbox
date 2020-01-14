class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :provider, :uid, :allow_password_change, :name, :nickname, :image, :email

  attribute :connected_to_discogs do |user|
    user.discogs_api.authenticated?
  end

  attribute :discogs_identity do |user|
    user.discogs_api.get_identity
  rescue
    nil
  end
end