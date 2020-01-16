class Release < ApplicationRecord
  belongs_to :artist, optional: true
  has_many :tracks, dependent: :nullify
  has_and_belongs_to_many :users

end
