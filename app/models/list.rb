class List < ApplicationRecord
  has_many :bookmarks, dependent: :delete_all
  has_many :movies, through: :bookmarks, dependent: :destroy
  has_one_attached :photo

  validates :name, presence: true, uniqueness: true
end
