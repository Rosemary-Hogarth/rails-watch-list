class Movie < ApplicationRecord
  has_many :bookmarks

  validates :title, presence: true, uniqueness: true
  validates :overview, :poster_url, :rating, presence: true
end
