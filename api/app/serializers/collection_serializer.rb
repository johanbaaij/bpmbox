# frozen_string_literal: true

class CollectionSerializer
  include FastJsonapi::ObjectSerializer
  set_id :username
  attributes :username, :discogs_user
end
