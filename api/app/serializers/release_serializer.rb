# frozen_string_literal: true

class ReleaseSerializer
  include FastJsonapi::ObjectSerializer
  attributes :artist, :title
end
