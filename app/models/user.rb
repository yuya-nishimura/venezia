class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable, :rememberable, :omniauthable, omniauth_providers: [:twitter]

  # ユーザーは複数のリストと映画を持つ
  has_many :lists, dependent: :destroy
  has_many :movies, through: :lists, dependent: :destroy

  # Twitter認証で受け取った情報からユーザーを検索または作成する
  def self.from_omniauth(auth)
    find_or_create_by(uid: auth[:uid]) do |user|
      user.uid = auth[:uid]
      user.name = auth[:info][:name]
      user.image = auth[:info][:image]
    end
  end

  def get_bigger_image
    image.gsub(/_normal/, "_bigger")
  end

  def get_original_image
    image.gsub(/_normal/, "")
  end
end
