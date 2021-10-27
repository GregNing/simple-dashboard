# frozen_string_literal: true

module Mutations
  class OmniauthLogin < Mutations::BaseMutation
    graphql_name 'OmniauthLogin'

    argument :omniauth_attributes, Types::Input::OmniauthInputType, required: true

    field :user, Types::UserType, null: false

    def resolve(omniauth_attributes:)
      auth = OpenStruct.new(omniauth_attributes.to_h)
      user = User.from_omniauth(auth)

      if user.present?
        context[:current_user] = user
        MutationResult.call(obj: { user: user }, success: true)
      else
        raise AuthorizationError
      end
    end
  end
end
