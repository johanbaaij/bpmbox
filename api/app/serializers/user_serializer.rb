class UserSerializer
  include FastJsonapi::ObjectSerializer
  attributes :provider, :uid, :allow_password_change, :name, :nickname, :image, :email
end