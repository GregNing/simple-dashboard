# frozen_string_literal: true

module Mutations
  class UpdatePasswordWithToken < Mutations::BaseMutation
    graphql_name 'UpdatePasswordWithToken'

    argument :password,              String, required: true
    argument :password_confirmation, String, required: true
    argument :reset_password_token,  String, required: true

    def resolve(reset_password_token:, **attrs)
      resource = User.with_reset_password_token(reset_password_token)

      raise ParamsError, 'Reset Token not found' if resource.blank? || !resource.reset_password_period_valid?
      raise ParamsError, 'Passwords do not match' if args[:password] != args[:password_confirmation]

      if resource.update(attrs)
        MutationResult.call(success: true)
      else
        MutationResult.call(success: false, errors: resource.errors)
      end
    end
  end
end
