class User < ApplicationRecord
  include GraphQL::Interface

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable,
         :database_authenticatable, :token_authenticatable

  validates :name, presence: true
  validates :email, presence: true, uniqueness: { message: 'email_should_uniqueness' }
  validates :email, format: { with: Devise.email_regexp }

  has_many :oauth_providers, dependent: :destroy

  def self.from_omniauth(auth)
    OauthProvider.find_for_oauth(auth).user
  end
end
