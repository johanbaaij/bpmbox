# frozen_string_literal: true

class Track < ApplicationRecord
  belongs_to :release, optional: true

  def artist
    self[:artist] || release.artist
  end
end
