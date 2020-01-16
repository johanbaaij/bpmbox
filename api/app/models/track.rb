class Track < ApplicationRecord
  belongs_to :artist, optional: true
  belongs_to :release, optional: true
end
