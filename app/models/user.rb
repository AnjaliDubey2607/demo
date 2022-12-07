class User < ApplicationRecord
  validates :name, presence: :true
  validates :role, presence: :true
  validates :email, presence: :true, uniqueness: :true

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,:omniauthable, omniauth_providers: [:google_oauth2]

  has_many :orders, dependent: :destroy
	has_many :carts, dependent: :destroy
	has_many :products, dependent: :destroy
  
  scope :user_name, ->(user) { User.where(id: user).pluck(:name).join.capitalize }

  def self.from_google(data)
    user = User.find_by(email: data[:email])
    unless user.present?
      user = User.create(uid: data[:uid],
      email: data[:email],
      password: Devise.friendly_token[0,20],
      role: "Customer",
      name: data[:name]
      )
    end
    user
  end
end
