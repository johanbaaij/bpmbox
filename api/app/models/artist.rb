class Artist < ApplicationRecord
  has_many :releases, dependent: :nullify
  has_many :songs, dependent: :nullify
end
