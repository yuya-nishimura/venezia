class List < ApplicationRecord
  validates :user_id, presence: true
  validates :name, presence: true, uniqueness: true
  validates :description, length: { maximum: 140 }

  # リストはユーザーに属し、複数の映画を持つ
  belongs_to :user
  has_many :movies, dependent: :destroy

end
