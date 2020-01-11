class Release < ApplicationRecord
  belongs_to :artist, optional: true
  has_many :songs, dependent: :nullify
end
