class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :posts
  has_many :favorites, dependent: :destroy
  has_many :good_places, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :alerts, dependent: :destroy
  has_many :schedules, dependent: :destroy
  attachment :image

  validates :name,length: {minimum: 2, maximum: 20}

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = "geust"
      user.country = "JP"
      user.password = "123456"
    end
  end

  def active_for_authentication?
    super && self.user_status?
  end
end
