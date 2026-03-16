class User < ApplicationRecord
  has_one_attached :image
  has_many :patterns, dependent: :destroy
  has_many :post, dependent: :destroy
  has_many :bookmarks, dependent: :destroy
  has_many :bookmarked_patterns, through: :bookmarks, source: :pattern
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
          :recoverable, :rememberable, :validatable

  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
    end
  end
  
end
