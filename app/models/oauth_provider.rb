class OauthProvider < ApplicationRecord
  belongs_to :user

  validates :uid, :name, presence: true

  PROVIDER_NAME = %w[google facebook].freeze

  validates_inclusion_of :name, in: PROVIDER_NAME

  def self.find_for_oauth(auth)
    user = build_or_update_user(auth)

    find_or_create_by(uid: auth.uid, name: auth.provider) do |provider|

      unless user.persisted?
        user.save
      end

      provider.user = user
    end
  end

  def self.build_or_update_user(auth)
    email = auth.email
    name = auth.name

    user = User.find_or_initialize_by(email: email) do |new_user|
      new_user.password = "##{Devise.friendly_token[0..20]}@"
    end

    if user.persisted?
      user.update(name: name) if user.name.blank? && name.present?
    else
      user.name = name
    end

    user
  end
end
