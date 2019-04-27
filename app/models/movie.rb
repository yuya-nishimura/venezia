class Movie < ApplicationRecord
  # 映画はリスト、ユーザーに属する
  belongs_to :list
  has_one :user, through: :list
  validates :title, presence: true, uniqueness: { scope: :list_id }

  def resized_poster(size)
    "https://image.tmdb.org/t/p/w#{size}#{poster}"
  end
end
