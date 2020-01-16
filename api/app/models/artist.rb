class Artist < ApplicationRecord
  has_many :releases, dependent: :nullify
  has_many :tracks, dependent: :nullify
end
