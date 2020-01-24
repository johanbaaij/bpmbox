# frozen_string_literal: true

class CollectionSerializer
  include FastJsonapi::ObjectSerializer
  attributes :username, :discogs_user
end
