# frozen_string_literal: true

module Types
  module Input
    class OmniauthInputType < ::Types::BaseInputObject
      description 'Attributes for creating or updating a user'
      argument :provider, String, required: true
      argument :uid, String, required: true
      argument :name, String, required: true
      argument :email, String, required: true
      argument :access_token, String, required: true
    end
  end
end
