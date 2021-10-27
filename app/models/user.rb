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

  validates :password,
            presence: true,
            length: { minimum: 8 }

  validate :password_requirements_are_met

  has_many :oauth_providers, dependent: :destroy

  def self.from_omniauth(auth)
    OauthProvider.find_for_oauth(auth).user
  end

  def password_requirements_are_met
    return if password.nil?

    rules = {
      ' must contain at least one lowercase letter' => /[a-z]+/,
      ' must contain at least one uppercase letter' => /[A-Z]+/,
      ' must contain at least one digit' => /\d+/,
      ' must contain at least one special character' => /[^A-Za-z0-9]+/
    }

    rules.each do |message, regex|
      errors.add(:password, message) unless password.match(regex)
    end
  end
end
