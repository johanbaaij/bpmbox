# frozen_string_literal: true

class Track < ApplicationRecord
  attr_accessor :artist_txt
  belongs_to :artist, optional: true
  belongs_to :release, optional: true
end
