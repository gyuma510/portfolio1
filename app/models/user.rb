class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :timeoutable, :lockable, :confirmable
  def self.guest
    find_or_create_by!(email: 'guests@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.confirmed_at = Time.now
    end
  end

  has_many :schools, dependent: :destroy
  has_many :students, dependent: :destroy
  has_many :teachers, dependent: :destroy
  has_many :teams, dependent: :destroy
end
