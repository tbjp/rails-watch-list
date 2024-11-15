class List < ApplicationRecord
  has_many :bookmarks, dependent: :delete_all
  has_many :movies, through: :bookmarks

  validates :name, presence: true, uniqueness: true
  has_one_attached :photo
end
