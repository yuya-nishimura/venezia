class Movie < ApplicationRecord
  # 映画はリストに属する
  belongs_to :list
end
