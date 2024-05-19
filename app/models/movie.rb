class Movie < ApplicationRecord
  has_many :bookmarks, dependent: :delete_all
  has_many :lists, through: :bookmarks

  validates :title, presence: true, uniqueness: true
  validates :overview, :poster_url, :rating, presence: true
end
