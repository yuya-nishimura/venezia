class Movie < ApplicationRecord
  # 映画はリストに属する
  belongs_to :list
  validates :title, presence: true, uniqueness: { scope: :list_id }

  def resized_poster(size)
    "https://image.tmdb.org/t/p/w#{size}#{poster}"
  end
end
