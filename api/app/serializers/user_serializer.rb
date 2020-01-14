class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :provider, :uid, :allow_password_change, :name, :nickname, :image, :email

  attribute :connected_to_discogs do |user|
    begin
      user.discogs_api.get_identity
      user.discogs_api.authenticated?
    rescue
      false
    end
  end

  attribute :discogs_identity do |user|
    begin
      user.discogs_api.get_identity
    rescue
      nil
    end
  end
end